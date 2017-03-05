class CreatePlaylistSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :playlist_songs do |t|
      t.references :playlist_version, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
