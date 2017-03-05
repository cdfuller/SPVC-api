class CreatePlaylistVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :playlist_versions do |t|
      t.references :playlist, foreign_key: true
      t.string :spotify_snapshot_id

      t.timestamps
    end
  end
end
