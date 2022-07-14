class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.integer :followers
      t.text :genres, array: true, default: []
      t.string :image
      t.string :name
      t.integer :popularity

      t.timestamps
    end
  end
end
