class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :community_participant_role, presence: true
  validates :gthread_id, presence: true
  validates :text, presence: true
  
  belongs_to :user
  belongs_to :gthread
  has_many :notifications, dependent: :destroy
  
  def my_comment
    ApplicationController.renderer.render partial: "comments/my_comment", locals: { tcomment: self }
  end
  
  def others_comment
    ApplicationController.renderer.render partial: "comments/others_comment", locals: { tcomment: self }
  end
  
  def comment_count_template
    ApplicationController.renderer.render partial: "gthreads/tcomment_count", locals: { gthread: self.gthread }
  end
end
