class AddArtistToTracks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tracks, :artist, foreign_key: true
  end
end
