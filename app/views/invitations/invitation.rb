class Invitation < ApplicationRecord
  validates :family_name, presence: true, length: { maximum: 15 }
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :email, presence: true#, uniqueness: true
  #, format: { with: /\A[A-Za-z0-9._+]+@[A-Za-z]+\.[A-Za-z]+\z/ }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #format: { with: VALID_EMAIL_REGEX },
                    #uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
  
  belongs_to :user
  
  # サイト招待用のメールを送信する
  def send_invitation_email
    UserMailer.invitation(self).deliver_now #()内の@inviteeを => self に
  end
  
  private
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = self.email.downcase
    end
end
