class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :image, presence: true
  validates :description, presence: true
end
