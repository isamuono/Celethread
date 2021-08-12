class Channel < ApplicationRecord
  validates :user_id, presence: true
  validates :community_id, presence: true
  validates :channelName, presence: true,
    uniqueness: { scope: [:community_id] } # 1つのコミュニティーに同名のチャンネルは作れない。
  validates :description, length: { maximum: 2000 }
  validates :color, presence: { message: "を選択してください" },
    uniqueness: { scope: [:community_id] } # 1つのコミュニティーに同じ色のチャンネルは作れない。
  validates :public, presence: { message: "を選択してください" }
  
  has_many :channel_participants, source: 'user', dependent: :destroy
  has_many :users, through: :channel_participants
  belongs_to :community
  has_many :gthreads, dependent: :destroy
  has_many :events, dependent: :destroy
  
  before_create :set_cha_uid
  
  private
    def set_cha_uid
      while self.id.blank? || Channel.find_by(id: self.id).present? do
        self.id = SecureRandom.alphanumeric(6)
      end
    end
end
