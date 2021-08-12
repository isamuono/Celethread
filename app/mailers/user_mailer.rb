class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "[サイト名]アカウント確認のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "[サイト名]パスワード再設定の手続き"
  end
  
  
  def invitation(user, community_id)
    @user = user
    @inviter = User.find(@user.invited_by)
    @community_id = Community.find(community_id).id
    mail to: @user.email, subject: "[サイト名]「コミュニティー名」より招待されています"
  end
end
