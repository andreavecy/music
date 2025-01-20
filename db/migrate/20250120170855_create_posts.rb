class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :image
      t.string :description
      t.integer :likes

      t.timestamps
    end
  end
end
