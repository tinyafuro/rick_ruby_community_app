class AddPictureToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :picture, :string
  end
end
