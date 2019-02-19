class CreateCommunityJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :community_joins do |t|
      t.integer :community_id
      t.integer :user_id

      t.timestamps
    end
    add_index :community_joins, :community_id
    add_index :community_joins, :user_id
    add_index :community_joins, [:community_id, :user_id], unique: true
  end
end
