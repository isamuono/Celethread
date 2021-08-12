class Notification < ApplicationRecord
  #validates :visited_id, presence: true,
    #uniqueness: { scope: [:thread_reaction_id, :comment_id] }
  
  default_scope -> { order(created_at: :desc) } # デフォルトの並び順を作成日時の降順で指定
  belongs_to :gthread, optional: true
  belongs_to :thread_reaction, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
