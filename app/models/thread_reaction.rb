class ThreadReaction < ApplicationRecord
  validates :user_id, presence: true
  validates :gthread_id, presence: true
  validates :entity_name, presence: false
  validates :images, presence: true
  
  #validates_uniqueness_of :gthread_id, scope: :user_id
  
  belongs_to :user
  belongs_to :gthread
  has_many :reaction_images
  #has_many :thread_reaction_users#, through: :reaction_images, source: 'user'
  has_many :notifications, dependent: :destroy
  
  def template
    current_user = User.find_by(id: user_id)
    ApplicationController.renderer.render partial: "thread_reactions/treactions_list", locals: { gthread: self.gthread, treaction: self, current_user: current_user }
  end
  
  #def reaction_count_template
  #  ApplicationController.renderer.render partial: "gthreads/treaction_count", locals: { gthread: self.gthread, treaction: self }
  #end
  
  def reaction_count_all_template
    ApplicationController.renderer.render partial: "gthreads/treaction_count_all", locals: { gthread: self.gthread }
  end
end
