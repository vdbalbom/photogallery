class AddContributorRefToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :contributors, index: true, foreign_key: true
  end
end
