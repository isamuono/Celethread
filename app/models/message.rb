class Message < ApplicationRecord
  
  mount_uploaders :images, ImagesUploader
  
end
