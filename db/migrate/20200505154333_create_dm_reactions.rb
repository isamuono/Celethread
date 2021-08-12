class CreateDmReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :dm_reactions do |t|
      t.integer :user_id
      t.integer :message_id
      t.string  :entity_name
      t.string  :images

      t.timestamps
    end
  end
end
