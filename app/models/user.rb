class User < ApplicationRecord
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :accountName, presence: true
  validates :email, presence: true#, uniqueness: true
  #, format: { with: /\A[A-Za-z0-9._+]+@[A-Za-z]+\.[A-Za-z]+\z/ }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #format: { with: VALID_EMAIL_REGEX },
                    #uniqueness: { case_sensitive: false }
  
  has_secure_password
  #PW_REGEX = /\A(?=.?[a-z])(?=.?\d)[a-z\d]{8,20}+\z/i  ⬅️テストユーザー作成時のパスを簡単にするため
  #validates :password, format: {with: PW_REGEX}
  
  validates :images, presence: false
  validates :self_introduction, presence: false, length: { maximum: 3000 }
  validates :remember_digest, presence: false
  
  mount_uploader :images, ImageUploader
  
  has_many :invitations
  has_many :community_participants, source: 'community'
  has_many :communities, through: :community_participants
  has_many :channel_participants, source: 'channel'
  has_many :channels, through: :channel_participants
  has_many :gthreads
  has_many :events
  has_many :thread_reactions
  has_many :comments
  has_many :direct_messages
  has_many :messages
  has_many :dm_reactions
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  #インスタンスメソッドremember_token, activation_token, reset_tokenのセッターとゲッターを一括指定
  attr_accessor :remember_token, :activation_token, :reset_token, :invite_token
  
  #＜永続的ログイン機能＞
  before_save   :downcase_email
  # 有効化トークンや有効化ダイジェストはユーザーオブジェクトが作成される前に作成しておく必要がある
  before_create :create_activation_digest
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token #インスタンスメソッドのremember_token(24行目)が呼ばれる
    update_attribute(:remember_digest, User.digest(remember_token)) #記憶ダイジェストの更新
  end
  
  # 渡されたトークンがremember（もしくはアカウント有効化）ダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)   # attributeにrememberかactivateが入る
    digest = send("#{attribute}_digest") # モデルの属性である〜_digestにアクセス
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # <ユーザー有効化メソッド>
  # アカウントを有効にする
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now #()内の@userを => self に
  end
  
  def activation_expired?
    self.activate_sent_at < 24.hours.ago
  end
  
  # <パスワードリセット>
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
    #update_columns(reset_digest: User.digest(reset_token), :reset_sent_at: Time.zone.now)
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 1.hours.ago
  end
  
  # <招待機能>
  def send_invite_email(community_id)
    UserMailer.invitation(self, community_id).deliver_now #()内の@inviteeを => self に
  end
  
  # ユーザー招待の属性（トークンとダイジェストと、招待したユーザーのid）を作成する
  def create_invite_digest
    self.invite_token = User.new_token
    update_attributes(invite_digest: User.digest(invite_token), invite_sent_at: Time.zone.now)
  end

  # 招待の期限が切れている場合はtrueを返す
  def invitation_expired?
    self.invite_sent_at < 24.hours.ago
  end
  
  def can_access?(channel)
    if self.community_participants.where(community_id: channel.community_id)# チャットルームへ入室するための条件を記述
      true
    else
      false
    end
  end
  
  # 参加していないコミュニティーのチャンネルの
  def is_com_participants?(channel)
    if self.community_participants.where(community_id: channel.community_id).exists?
      true
    else
      false
    end
  end
  
  private
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = self.email.downcase
    end
    
    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
      # @user.activation_digest => ハッシュ値が入る
      
      # 2020/7/31追記
      self.activate_sent_at = Time.zone.now
    end
end
