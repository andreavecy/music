class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :image
      t.string :name
      t.integer :popularity
      t.date :release_date
      t.integer :total_tracks
      t.text :genres, array: true, default: []
      t.string :label

      t.timestamps
    end
  end
end
