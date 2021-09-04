class InvitationsController < ApplicationController
  before_action :has_admin_right?, only: :create
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
    session[:previous_url] = request.referer
    
    if current_user == nil
      redirect_to root_url
    else
      @user = User.new
    end
  end
  
  def create
    if params[:invitee][:email].blank?
      flash.now[:danger] = "メールアドレスを入力してください"
      render :new
    elsif @user = User.find_by(email: invitee_params[:email])
      @user.update(invited_by: current_user.id)
      @user.create_invite_digest
      @user.send_participation_email(params[:community_id], params[:communityName])
      flash[:info] = "入力したメールアドレス宛に招待メールを送信しました！"
      redirect_to session[:previous_url]
    else
      @user = User.create(family_name: '佐藤', first_name: 'takeru', accountName: '佐藤takeru', email: invitee_params[:email].downcase, password: 'dummydummy', invited_by: current_user.id, temporary: true)
      @user.create_invite_digest
      @user.send_invite_email(params[:community_id], params[:communityName])
      flash[:info] = "入力したメールアドレス宛に招待メールを送信しました！"
      redirect_to session[:previous_url]
    end
  end
  
  def edit
    @user = User.find_by(email: params[:email])
    if @user.temporary
      @user.family_name = nil
      @user.first_name = nil
      @user.accountName = nil
    else
      log_in @user
      
      if cp = CommunityParticipant.find_by(user_id: @user.id, community_id: params[:community_id])
        redirect_to channels_gthreads_path(@user.communities.order(:created_at).first.channels.first.id), info: "あなたはすでに#{ params[:communityName] }のメンバーです"
      else
        CommunityParticipant.create(role: 2, user_id: @user.id, community_id: params[:community_id])
        redirect_to channels_gthreads_path(@user.communities.order(:created_at).first.channels.first.id), success: "#{ params[:communityName] }へようこそ！"
      end
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      flash[:danger] = "パスワードを入力してください"
      render :edit
    elsif @user.update(user_params)
      @user.activate
      @user.update(temporary: false)
      log_in @user
      
      @participate_celeste = CommunityParticipant.new
      @participate_celeste.role = 2
      @participate_celeste.user_id = @user.id
      @participate_celeste.community_id = 'celestebot'
      @participate_celeste.save
      
      @participate = CommunityParticipant.new
      @participate.role = 2
      @participate.user_id = @user.id
      @participate.community_id = params[:community_id]
      @participate.save
      
      flash[:success] = "ようこそ Celethreadへ!"
      redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
    else
      flash.now[:danger] = "アカウントの作成に失敗しました"
      render :edit
    end

  end
  
  private
    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    # 正しいユーザーかどうか確認する
    def valid_user
      # アカウントがまだ有効化されていないか、もしくは一時的に(仮で)作られたアカウントでないか、
      # どちらか一方の条件に1つでも当てはまれば、falseを返す(valid_userメソッドを通過する)
      unless (@user && (!@user.activated? || !@user.temporary) && #  || !@user.temporary) 2021/8/25 追記
              @user.authenticated?(:invite, params[:id])) #params[:id]はメールアドレスに仕込まれたトークン
        redirect_to root_url, danger: "無効なリンクです。お使いのアカウントは既に有効になっているか、もしくは認証ができていません。"
      end
      
      #if @user.activated? && user.temporary == true
      #  redirect_to
      #elsif !@user.activated? && user.temporary == false
      #  false
      #elsif @user.activated? && user.temporary == false
      #  false
      #elsif !@user.activated? && user.temporary == true
      #  false
      #end
    end
    
    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.invitation_expired?
        flash[:danger] = "招待メールの有効期限が切れています"
        redirect_to root_url
      end
    end
    
    def invitee_params
      params.require(:invitee).permit(:family_name, :first_name, :accountName, :email, :password, :password_confirmation)
    end
    
    def user_params
      params.require(:user).permit(:family_name, :first_name, :accountName, :email, :password, :password_confirmation)
    end
end
