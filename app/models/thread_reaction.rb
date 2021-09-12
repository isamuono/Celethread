class ThreadReaction < ApplicationRecord
  validates :user_id, presence: true
  validates :gthread_id, presence: true
  validates :entity_name, presence: true, uniqueness: { scope: [:user_id, :gthread_id] }
  validates :images, presence: true, uniqueness: { scope: [:user_id, :gthread_id] }
  
  belongs_to :user
  belongs_to :gthread
  has_many :reaction_images
  has_many :notifications, dependent: :destroy
  
  def my_treaction
    ApplicationController.renderer.render partial: "thread_reactions/my_treaction", locals: { gthread: self.gthread, treaction: self }
  end
  
  def others_treaction
    ApplicationController.renderer.render partial: "thread_reactions/others_treaction", locals: { gthread: self.gthread, treaction: self }
  end
  
  def reaction_count_all_template
    ApplicationController.renderer.render partial: "gthreads/treaction_count_all", locals: { gthread: self.gthread }
  end
end
