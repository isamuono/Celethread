class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :directMessage_id
      t.string  :images
      t.text    :text, charset: :utf8mb4

      t.timestamps
    end
  end
end
