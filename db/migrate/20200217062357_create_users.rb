class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :family_name
      t.string  :first_name
      t.string  :accountName
      t.string  :email
      t.string  :images
      t.text    :self_introduction, charset: :utf8mb4
      t.boolean :temporary, default: false

      t.timestamps
    end
  end
end
