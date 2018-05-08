class RenameGroupImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :groups, :image, :group_image
  end
end
