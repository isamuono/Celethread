class InvitationsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
    session[:previous_url] = request.referer
    
    if current_user == nil
      redirect_to root_url
    else
      #@invitation = Invitation.new
      @user = User.new
    end
  end
  
  def create
    #@invitation = Invitation.new(invitation_params)
    #@invitation.user_id = current_user.id
    #if @invitation.save
    #  @invitation.send_invitation_email
    #  redirect_to root_url, success: '入力したメールアドレス宛に送信しました'
    #else
    #  flash.now[:danger] = "メール送信に失敗しました"
    #  render :new
    #end
    
    if params[:invitee][:email].blank?
      flash[:danger] = "メールアドレスを入力してください。"
      render :new
    elsif User.find_by(email: params[:invitee][:email])
      flash.now[:danger] = "そのメールアドレスはすでに招待済みです。"
      render :new
    else
      @user = User.create(family_name: "佐藤", first_name: "takeru", accountName: "佐藤takeru", email: params[:invitee][:email].downcase, password: "dummydummy", invited_by: current_user.id)
      @user.create_invite_digest
      @user.send_invite_email(params[:community_id])
      flash[:info] = "招待メールを送信しました！"
      redirect_to session[:previous_url]
    end
  end
  
  def edit
    if @user
      @user.family_name = nil
      @user.first_name = nil
      @user.accountName = nil
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      #flash[:danger] = "メールアドレスを入力してください。"
      render :edit
    elsif @user.update_attributes(invitee_params)
      @user.activate
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
      
      flash[:success] = "ようこそ Celesteへ!"
      redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
    else
      flash[:danger] = "アカウントの作成に失敗しました"
      render :edit
    end

  end
  
  private
    def get_user
      @user = User.find_by(email: params[:email])
    end
  
    #正しいユーザーかどうか確認する
    def valid_user
      unless (@user && !@user.activated? &&
              @user.authenticated?(:invite, params[:id])) #params[:id]はメールアドレスに仕込まれたトークン
        redirect_to root_url, danger: "無効なリンクです。お使いのアカウントは有効化、もしくは認証ができていません。"
      end
    end
  
    #トークンが期限切れかどうか確認する
    def check_expiration
      if @user.invitation_expired?
        flash[:danger] = "招待メールの有効期限が切れています"
        redirect_to root_url
      end
    end
    #def invitation_params
    #  params.require(:invitation).permit(:family_name, :first_name, :email)
    #end
    
    def invitee_params
      params.require(:user).permit(:family_name, :first_name, :accountName, :email, :password, :password_confirmation)
    end
end
