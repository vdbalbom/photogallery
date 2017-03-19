class FixContributorRefToPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_reference :photos, :contributors, index: true, foreign_key: true
    add_reference :photos, :contributor, index: true, foreign_key: true
  end
end
