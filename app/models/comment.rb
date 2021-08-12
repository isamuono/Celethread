class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :community_participant_role, presence: true
  validates :gthread_id, presence: true
  validates :text, presence: true
  
  belongs_to :user
  belongs_to :gthread
  has_many :notifications, dependent: :destroy
  
  def template
    current_user = User.find_by(id: user.id)
    ApplicationController.renderer.render partial: "comments/comment", locals: { tcomment: self, current_user: current_user }
  end
  
  def comment_count_template
    ApplicationController.renderer.render partial: "gthreads/tcomment_count", locals: { gthread: self.gthread }
  end
end
