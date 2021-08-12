class CreateCommunityParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :community_participants do |t|
      t.integer :role
      t.integer :user_id
      t.string  :community_id
      t.integer :community_n_sw
      t.integer :channel_n_sw
      t.integer :thread_new_n_sw
      t.integer :thread_update_n_sw
      t.integer :thread_reaction_n_sw
      t.integer :thread_comment_n_sw

      t.timestamps
    end
  end
end
