class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました"
      redirect_to login_path
    else
      flash.now[:danger] = "メール送信に失敗しました"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      # @user.errors.add(:password, :blank)
      render :edit
    elsif @user.update_attributes(user_params)
      # ユーザーのリセットダイジェストを、nilで更新・保存する。
      log_in @user
      flash[:success] = "パスワードが更新されました"
      redirect_to root_url
    else
      render :edit
    end
  end
  
  private
    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    # 取得したユーザーが存在していて、かつ有効化されていて、かつ認証済みであるユーザーかどうかを確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id])) # ダイジェストとトークンの一致を確認
        redirect_to root_url, danger: "無効なリンクです。お使いのアカウントは有効化、もしくは認証ができていません。"
      end
    end
    
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期限が切れています"
        redirect_to new_password_reset_url
      end
    end
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
