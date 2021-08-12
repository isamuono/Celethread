class Schedule < ApplicationRecord
  
  
  belongs_to :community
  has_one :gthread
  has_one :event
end
