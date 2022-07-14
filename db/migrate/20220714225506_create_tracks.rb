class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.references :album, null: false, foreign_key: true
      t.integer :disc_number
      t.integer :duration_ms
      t.string :name
      t.string :preview_url
      t.integer :track_number

      t.timestamps
    end
  end
end
