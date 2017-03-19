class AddPhotoRefToTaggers < ActiveRecord::Migration[5.0]
  def change
    add_reference :taggers, :photo, index: true, foreign_key: true
  end
end
