class AddImageToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :image
  end
end
