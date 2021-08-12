class CreateChannelParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :channel_participants do |t|
      t.integer :user_id
      t.string  :channel_id
      t.string  :color
      t.integer :reading_last_datetime

      t.timestamps
    end
  end
end
