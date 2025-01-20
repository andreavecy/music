class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :image, presence: true
  validates :description, presence: true
end
