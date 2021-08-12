class CreateThreadReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :thread_reactions do |t|
      t.integer :user_id
      t.string  :gthread_id
      t.string  :entity_name
      t.string  :images

      t.timestamps
    end
  end
end
