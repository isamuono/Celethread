class UsersController < ApplicationController
  before_action :login_check, :set_user_id_to_cookie, only: :update
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.images = nil
    @user.self_introduction = nil
    @user.remember_digest = nil
    
    if @user.save
      @user.send_activation_email
      redirect_to root_url, success: 'メールを送信しました'
    elsif User.find_by(email: user_params[:email]).present?
      flash.now[:danger] = 'そのメールアドレスはすでに使用されています'
      render :new
    else
      flash.now[:danger] = 'メール送信に失敗しました'
      render :new
    end
  end
  
  #def edit
  #  @user_edit = User.find(params[:id])
  #end
  
  def update
    @user = current_user
    
    if @user.update(user_params)
      redirect_to request.referer, success: 'プロフィール情報を変更しました'
    else
      redirect_to request.referer, danger: 'プロフィール情報の変更に失敗しました'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:family_name, :first_name, :accountName, :email, :password, :password_confirmation, :images, :self_introduction)
    end
end
