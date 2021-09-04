class ThreadReaction < ApplicationRecord
  validates :user_id, presence: true
  validates :gthread_id, presence: true
  validates :entity_name, presence: true, uniqueness: { scope: [:user_id, :gthread_id] }
  validates :images, presence: true, uniqueness: { scope: [:user_id, :gthread_id] }
  
  belongs_to :user
  belongs_to :gthread
  has_many :reaction_images
  #has_many :thread_reaction_users#, through: :reaction_images, source: 'user'
  has_many :notifications, dependent: :destroy
  
  def template
    current_user = User.find_by(id: user_id)
    ApplicationController.renderer.render partial: "thread_reactions/treactions_list", locals: { gthread: self.gthread, treaction: self, current_user: current_user }
  end
  
  def reaction_count_all_template
    ApplicationController.renderer.render partial: "gthreads/treaction_count_all", locals: { gthread: self.gthread }
  end
end
