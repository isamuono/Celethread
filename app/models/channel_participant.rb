class ChannelParticipant < ApplicationRecord
  validates :role, presence: false
  validates :user_id, presence: true
  validates :community_id, presence: true
  
  belongs_to :user
  belongs_to :community
  belongs_to :channel
  
  #has_many :roles
end
