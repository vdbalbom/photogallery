class Post < ApplicationRecord
  include Bootsy::Container

  belongs_to :contributor

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
  validates :content, length: { maximum: 10000 }

end
