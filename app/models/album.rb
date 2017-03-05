class Album < ApplicationRecord
  has_many :songs
  has_many :album_artists
  has_many :artists, through: :album_artists

  def self.get_album(spotify_album)
    a = Album.find_or_initialize_by(spotify_id: spotify_album.id)

    if a.persisted? == false
      a.name = spotify_album.name
      a.spotify_id = spotify_album.id
      a.artists = spotify_album.artists.map do |spotify_artist|
        Artist.get_artist(spotify_artist)
      end
      a.save
    end

    return a
  end
end
