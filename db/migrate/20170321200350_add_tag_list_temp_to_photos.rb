class AddTagListTempToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :tag_list_temp, :string
  end
end
