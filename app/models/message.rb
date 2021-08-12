class Message < ApplicationRecord
  
  mount_uploader :images, ImagesUploader
  
end
