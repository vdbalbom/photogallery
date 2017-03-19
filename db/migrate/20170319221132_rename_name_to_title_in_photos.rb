class RenameNameToTitleInPhotos < ActiveRecord::Migration[5.0]
  def change
    rename_column :photos, :name, :title
  end
end
