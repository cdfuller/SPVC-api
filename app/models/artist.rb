class Artist < ApplicationRecord
  has_many :artist_songs
  has_many :songs, through: :artist_songs

  def self.get_artist(spotify_artist)
    a = Artist.find_or_initialize_by(spotify_id: spotify_artist.id)

    if a.persisted? == false
      a.name = spotify_artist.name
      a.spotify_id = spotify_artist.id
      a.save
    end

    return a
  end
end
