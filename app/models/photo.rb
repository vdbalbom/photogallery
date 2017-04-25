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

  def add_tags tag_name_list
    tag_name_list.each do |tag_name|
      tag = Tag.find_by(name: tag_name)
      tag = Tag.create(name: tag_name) if tag.nil?
      Tagger.create(photo_id: self.id, tag_id: tag.id)
    end
  end

  def update_tags tag_name_list
    delete_tags
    add_tags tag_name_list
  end

  def delete_tags
    self.taggers.each do |tagger|
      tag = Tag.find(tagger.tag_id)
      tagger.delete
      tag.delete if tag.photos.count == 0
    end
  end

end
