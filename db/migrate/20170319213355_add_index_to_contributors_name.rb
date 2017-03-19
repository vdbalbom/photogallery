class AddIndexToContributorsName < ActiveRecord::Migration[5.0]
  def change
    add_index :contributors, :name, unique: true
  end
end
