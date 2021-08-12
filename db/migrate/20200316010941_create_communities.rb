class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities, id: :string do |t|
      t.string   :communityName
      t.integer  :category
      t.integer  :subcategory
      t.string   :prefecture
      t.integer  :sex
      t.string   :scale
      t.string   :images
      t.text     :description, charset: :utf8mb4
      t.integer  :user_id
      t.integer  :public

      t.timestamps
    end
  end
end