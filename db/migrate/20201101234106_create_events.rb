class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer   :user_id
      t.string    :community_id
      t.string    :channel_id
      t.string    :gthread_id
      t.string    :title, charset: :utf8mb4
      t.string    :place, charset: :utf8mb4
      t.date      :alldaydate
      t.time      :starttime1
      t.time      :endtime1
      t.datetime  :startdate
      t.time      :starttime2
      t.datetime  :enddate
      t.time      :endtime2
      t.boolean   :daterange
      t.boolean   :allday
      t.json      :images
      t.text      :description, charset: :utf8mb4

      t.timestamps
    end
  end
end
