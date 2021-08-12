class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels, id: :string do |t|
      t.integer :user_id
      t.string  :community_id
      t.string  :channelName
      t.text    :description, charset: :utf8mb4
      t.string  :color
      t.integer :public

      t.timestamps
    end
  end
end
