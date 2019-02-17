class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.string :title
      t.text :body
      t.integer :rarity
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :communities, [:user_id, :created_at]
  end
end
