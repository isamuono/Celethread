class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
  
  #include CommonActions
  helper_method :current_user, :current_user_id, :logged_in?
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id]) #ユーザーIDのセッションが存在すれば、、、
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      #旧(引数不足) if user && user.authenticated?(cookies[:remember_token])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def log_in(user)
    session[:user_id] = user.id
    #cookies.signed["user.id"] = user.id #4/14追記
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end
  
  def login_check
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end
  
  def set_user_id_to_cookie
    if current_user
      cookies.signed["user.id"] = current_user.id
    end
  end
  
  # 参加していないコミュニティーへのアクセス制限
  def is_com_participant?
    # コミュニティー、チャンネル削除時に、当該チャンネルのidが含まれるURLから削除した場合にリダレクトで元のURLに戻れないため、
    # celestebotチャンネルのidが含まれるURLにリダレクトする
    if Channel.find_by(id: params[:channel_id]).present?
      channel = Channel.find_by(id: params[:channel_id])
      
      if current_user.community_participants.find_by(community_id: channel.community_id).present?
        true
      else
        redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
      end
    else
      redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
    end
    
    
  end
  
  # 現在のユーザーの権限による制限
  def has_admin_right?
    cp_current_user_role = CommunityParticipant.find_by(id: params[:cp_current_user_id]).role
    
    if cp_current_user_role == 1
      true
    elsif cp_current_user_role == 2
      redirect_to request.referer, danger: 'あなたには権限がありません'
    end
  end
end
