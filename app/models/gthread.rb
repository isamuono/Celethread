class Gthread < ApplicationRecord
  validates :user_id, presence: true
  validates :community_id, presence: true
  validates :channel_id, presence: true
  validates :event_id, presence: false
  validates :title, presence: true
  validates :images, presence: false
  validates :description, presence: true
  
  mount_uploaders :images, ImageUploader #mount_uploaders 複数
  
  UID_RANGE = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  generate_public_uid column: :g_uid, generator: PublicUid::Generators::RangeString.new(8, UID_RANGE)
  
  belongs_to :user
  belongs_to :community
  belongs_to :channel
  has_one :event, dependent: :destroy
  has_many :reaction_images
  has_many :thread_reactions, dependent: :destroy
  has_many :thread_reaction_users, through: :thread_reactions, source: 'user'
  #has_many :treaction_users, through: :thread_reactions, source: 'reaction_image'
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: 'user'
  has_many :notifications, dependent: :destroy
  
  def to_param
    g_uid
  end
  
  def my_gthread
    ApplicationController.renderer.render partial: "gthreads/my_gthread", locals: { gthread: self }
  end
  
  def others_gthread
    ApplicationController.renderer.render partial: "gthreads/others_gthread", locals: { gthread: self }
  end
end
