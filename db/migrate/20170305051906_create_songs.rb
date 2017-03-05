class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.references :album, foreign_key: true
      t.string :spotify_id

      t.timestamps
    end
  end
end
