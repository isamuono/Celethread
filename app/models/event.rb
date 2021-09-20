class Event < ApplicationRecord
  validates :user_id, presence: true
  validates :community_id, presence: true
  validates :channel_id, presence: true
  validates :gthread_id, presence: true
  validates :title, presence: true
  validates :place, presence: false
  validates :alldaydate, presence: { message: "を選択してください" }, if: :notdaterange?
  validates :starttime1, presence: false
  validates :endtime1, presence: false
  validates :startdate, presence: { message: "を選択してください" }, if: :daterange?
  validates :starttime2, presence: false
  validates :enddate, presence: { message: "を選択してください" }, if: :daterange?
  validates :endtime2, presence: false
  validates :daterange, presence: false
  validates :allday, presence: false
  validates :images, presence: false
  validates :description, presence: true
  
  validate :startdate_enddate_check
  
  # 日付範囲選択がfalseならstartdate, enddateは空でよい
  def daterange?
    return false if daterange == false
    true
  end
  
  # 日付範囲選択がtrueならalldaydateは空でよい
  def notdaterange?
    return false if daterange == true
  end
  
  def startdate_enddate_check
    #return unless startdate && enddate
    
    if daterange == false && allday == false && startdate >= enddate
      errors.add(:endtime1, "は［開始時間］より遅い時間を選択してください")
    elsif daterange == true && startdate >= enddate
      errors.add(:enddate, "は［開始日時］より遅い時間になるように選択してください")
    end
  end
  
  mount_uploaders :images, ImageUploader
  
  belongs_to :user
  belongs_to :community
  belongs_to :channel
  belongs_to :gthread, dependent: :destroy
  
  def self.next_id
    if self.count >= 1
      return self.maximum(:id) + 1
    else
      return 1
    end
  end
end
