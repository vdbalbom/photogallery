class AddPasswordDigestToContributors < ActiveRecord::Migration[5.0]
  def change
    add_column :contributors, :password_digest, :string
  end
end
