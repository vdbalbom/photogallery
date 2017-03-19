class AddTagRefToTaggers < ActiveRecord::Migration[5.0]
  def change
    add_reference :taggers, :tag, index: true, foreign_key: true
  end
end
