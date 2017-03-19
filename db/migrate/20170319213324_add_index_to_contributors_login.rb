class AddIndexToContributorsLogin < ActiveRecord::Migration[5.0]
  def change
    add_index :contributors, :login, unique: true
  end
end
