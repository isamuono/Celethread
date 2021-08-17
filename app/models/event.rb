class Event < ApplicationRecord
  validates :user_id, presence: true
  validates :community_id, presence: true
  validates :channel_id, presence: true
  validates :gthread_id, presence: true
  validates :title, presence: true
  validates :place, presence: false
  validates :alldaydate, presence: false#{ message: "を選択してください" }, if: :notdaterange?
  validates :starttime1, presence: false#{ message: "を選択してください" }, if: [:notdaterange?, :notallday?]
  validates :endtime1, presence: false#{ message: "を選択してください" }, if: [:notdaterange?, :notallday?]
  validates :startdate, presence: { message: "を選択してください" }, if: :daterange?
  validates :starttime2, presence: false#{ message: "を選択してください" }, if: [:daterange?, :notallday?]
  validates :enddate, presence: { message: "を選択してください" }, if: :daterange?
  validates :endtime2, presence: false#{ message: "を選択してください" }, if: [:daterange?, :notallday?]
  validates :daterange, presence: false
  validates :allday, presence: false
  validates :images, presence: false
  validates :description, presence: true
  
  validate :startdate_enddate_check
  
  def daterange?
    return false if daterange == false
    true
  end
  
  def notdaterange?
    return false if daterange == true
    true
  end
  
  def notallday?
    return false if allday == true
    true
  end
  
  def startdate_enddate_check
    #return unless startdate && enddate
    
    if daterange == false && allday == false && startdate >= enddate
      errors.add(:endtime1, "は［開始時間］より遅い時間を選択してください")
    elsif daterange == true && startdate >= enddate
      errors.add(:enddate, "は［開始日時］より遅い時間になるように選択してください")
    end
    
    #errors.add(:endtime1, "は［開始時間］より遅い時間を選択してください") if self.startdate >= self.enddate
  end
  
  mount_uploaders :images, ImageUploader
  
  belongs_to :user
  belongs_to :community
  belongs_to :channel
  has_one :gthread, dependent: :destroy
end
