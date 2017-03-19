class AddProfilePictureToContributors < ActiveRecord::Migration[5.0]
  def change
    add_attachment :contributors, :profile_picture
  end
end
