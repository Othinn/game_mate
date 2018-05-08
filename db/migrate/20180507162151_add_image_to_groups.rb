class AddImageToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :image, :string
  end
end
