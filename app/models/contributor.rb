class Contributor < ApplicationRecord
  has_many :photos

  validates :login, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }

  validates :description,length: {maximum: 200}
  validates :facebook_link, length: { maximum: 255 }
  validates :instagram_link,length: { maximum: 255 }
  validates :tumblr_link ,length: { maximum: 255 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 5, maximum: 20 }

  has_attached_file :profile_picture,
                    :styles => { :thumb => "200x200#"}
  validates_attachment :profile_picture, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment_size :profile_picture, :in => 0.megabytes..1.megabytes
end
