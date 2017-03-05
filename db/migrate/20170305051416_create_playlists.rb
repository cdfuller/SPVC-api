class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :spotify_id
      t.string :spotify_owner_name
      t.string :image_url

      t.timestamps
    end
  end
end
