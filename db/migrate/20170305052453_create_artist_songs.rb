class CreateArtistSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_songs do |t|
      t.references :artist, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
