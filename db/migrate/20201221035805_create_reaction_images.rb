class CreateReactionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :reaction_images do |t|
      t.string :emoji_id
      t.string :entity_name
      t.string :images

      t.timestamps
    end
  end
end
