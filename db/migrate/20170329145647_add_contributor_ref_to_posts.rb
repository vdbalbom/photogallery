class AddContributorRefToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :contributor, index: true, foreign_key: true
  end
end
