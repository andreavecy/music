class Track < ApplicationRecord
  belongs_to :album
  belongs_to :artist
  has_many :favorite_tracks
  has_many :users, :through => :favorite_tracks
end
