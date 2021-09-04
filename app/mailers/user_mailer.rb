class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "[Celethread]アカウント確認のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "[Celethread]パスワード再設定の手続き"
  end
  
  def invitation(user, community_id, communityName)
    @user = user
    @inviter = User.find(@user.invited_by)
    @community_id = community_id
    @communityName = communityName
    mail to: @user.email, subject: "[Celethread]#{ @communityName }に招待されています"
  end
  
  def participation(user, community_id, communityName)
    @user = user
    @inviter = User.find(@user.invited_by)
    @community_id = community_id
    @communityName = communityName
    mail to: @user.email, subject: "[Celethread]#{ @communityName }に招待されています"
  end
end
