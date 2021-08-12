class AccountActivationsController < ApplicationController
  before_action :get_user
  before_action :check_expiration
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate   #ユーザーモデルオブジェクト経由でアカウントを有効化する
      log_in user
      
      @participate = CommunityParticipant.new
      @participate.role = 2
      @participate.user_id = user.id
      @participate.community_id = 'celestebot'
      @participate.save
      
      flash[:success] = "アカウントが有効になりました！"
      redirect_to root_url
    else
      flash[:danger] = "アカウントの有効化に失敗しました"
      redirect_to root_url
    end
  end
  
  private
    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    def check_expiration
      if @user.activation_expired?
        flash[:danger] = "アカウント有効化の期限が切れています"
        redirect_to root_url
      end
    end
end
