class Tag < ApplicationRecord
  has_many :taggers
  has_many :photos, through: :taggers
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
