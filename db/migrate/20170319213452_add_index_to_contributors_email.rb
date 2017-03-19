class AddIndexToContributorsEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :contributors, :email, unique: true
  end
end
