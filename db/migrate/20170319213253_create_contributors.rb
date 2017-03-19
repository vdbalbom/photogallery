class CreateContributors < ActiveRecord::Migration[5.0]
  def change
    create_table :contributors do |t|
      t.string :login
      t.string :name
      t.string :description
      t.string :email
      t.string :facebook_link
      t.string :instagram_link
      t.string :tumblr_link

      t.timestamps
    end
  end
end
