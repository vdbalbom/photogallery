class Tag < ApplicationRecord
  has_many :taggers
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
