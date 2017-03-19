class Photo < ApplicationRecord
  belongs_to :contributors
  has_many :taggers

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }

  has_attached_file :image,
                    :styles => { :thumb => "100x100#",
                                 :big_square => "200x200#",
                                 :original => "100>x447"}
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment_size :image, :in => 0.megabytes..2.megabytes
end
