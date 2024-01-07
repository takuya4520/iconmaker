class Post < ApplicationRecord
  belongs_to :user

	validates :title, presence: true, length: { maximum: 255 }
  validates :taste, presence: true, length: { maximum: 255 }
end
