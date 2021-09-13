class Community < ApplicationRecord
  validates :user_id, presence: true
  validates :communityName, presence: true, uniqueness: true
  validates :category_id, presence: { message: "を選択してください" }
  validates :subcategory_id, presence: { message: "を選択してください" }, inclusion: { in: (1..43) }
  validates :prefecture_id, presence: { message: "を選択してください" }
  validates :sex, presence: false
  validates :scale, presence: false
  validates :images, presence: false
  validates :description, presence: false
  validates :public, presence: true, inclusion: { in: [0, 1, 2] } # 0はcelestebot
  
  def daterange?
    return false if daterange == false
    true
  end
  
  mount_uploader :images, ImageUploader
  
  has_many :community_participants, source: 'user', dependent: :destroy
  has_many :users, through: :community_participants
  has_many :channels, dependent: :destroy
  has_many :gthreads, dependent: :destroy
  has_many :events, dependent: :destroy
  belongs_to :category
  belongs_to :subcategory
  belongs_to :prefecture
  #has_many :direct_messages, dependent: :destroy
  
  before_create :set_com_uid
  
  private
    def set_com_uid
      while self.id.blank? || Community.find_by(id: self.id).present? do
        self.id = SecureRandom.alphanumeric(6)
      end
    end
end
