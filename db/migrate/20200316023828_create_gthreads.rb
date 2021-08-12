class CreateGthreads < ActiveRecord::Migration[5.2]
  def change
    create_table :gthreads do |t|
      t.integer  :user_id
      t.string   :community_id
      t.string   :channel_id
      t.integer  :event_id
      t.string   :title, charset: :utf8mb4
      t.json     :images
      t.text     :description, charset: :utf8mb4
      t.string   :g_uid, null: false

      t.timestamps null: false
    end
  end
end
