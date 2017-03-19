class Admin < ApplicationRecord
  validates :login, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :site_title, presence: true, length: { maximum: 50 }
  validates :site_description, length: { maximum: 500 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 5, maximum: 20 }
end
