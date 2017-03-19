class AddIndexToAdminsLogin < ActiveRecord::Migration[5.0]
  def change
    add_index :admins, :login, unique: true
  end
end
