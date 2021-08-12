class CommunityParticipant < ApplicationRecord
  validates :role, presence: true, inclusion: { in: [0, 1, 2] }
  validates :user_id, presence: true,
    uniqueness: { scope: [:community_id], message: "あなたはすでにこのコミュニティーのメンバーです" }
  validates :community_id, presence: true
  validates :community_n_sw, presence: false
  validates :channel_n_sw, presence: false
  validates :thread_new_n_sw, presence: false
  validates :thread_update_n_sw, presence: false
  validates :thread_reaction_n_sw, presence: false
  validates :thread_comment_n_sw, presence: false
  
  
  belongs_to :user
  belongs_to :community
  
  has_many :roles
end
