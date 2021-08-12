class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.integer :community_id
      t.integer :channel_id
      t.integer :thread_id
      t.string  :title
      t.date    :startdate
      t.date    :enddate
      t.time    :starttime
      t.time    :endtime
      t.string  :place
      t.string  :note

      t.timestamps
    end
  end
end
