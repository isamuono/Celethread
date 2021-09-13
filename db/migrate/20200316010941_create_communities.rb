class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities, id: :string do |t|
      t.string   :communityName
      t.integer  :category_id
      t.integer  :subcategory_id
      t.integer  :prefecture_id
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
