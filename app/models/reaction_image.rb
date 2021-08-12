class ReactionImage < ApplicationRecord
  mount_uploader :images, ImageUploader
  
  #belongs_to :user, optional: true
  #belongs_to :gthread, optional: true
  belongs_to :thread_reaction, optional: true
end
