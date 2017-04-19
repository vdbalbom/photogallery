class Photo < ApplicationRecord
  belongs_to :contributor
  has_many :taggers
  has_many :tags, through: :taggers

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }

  validates :image, presence: true
  has_attached_file :image,
                    :styles => { :thumb => "200x200#",
                                 :big_square => "400x400#"}
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment_size :image, :in => 0.megabytes..2.megabytes

  VALID_TAG_LIST = /\A(\s)*(\#[a-z|A-Z|\s|&|0-9]+)*\z/x
  validates :tag_list_temp, format: { with: VALID_TAG_LIST,
                                      message: "Wrong format for tags." },
                            length: {maximum: 500}

end
