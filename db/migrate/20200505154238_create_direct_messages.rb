class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.integer :user_id
      t.string  :community_id
      t.integer :obj_user_id
      t.integer :main_sw
      t.integer :community_sw

      t.timestamps
    end
  end
end
