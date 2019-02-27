class AddTagToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :tag, :string
  end
end
