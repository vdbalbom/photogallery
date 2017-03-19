class CreateTaggers < ActiveRecord::Migration[5.0]
  def change
    create_table :taggers do |t|

      t.timestamps
    end
  end
end
