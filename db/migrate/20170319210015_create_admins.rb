class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :login
      t.string :site_title
      t.string :site_description

      t.timestamps
    end
  end
end
