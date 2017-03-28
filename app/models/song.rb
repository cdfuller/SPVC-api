class Song < ApplicationRecord
  belongs_to :album
  has_many :artist_songs
  has_many :artists, through: :artist_songs

  def self.get_song(spotify_song)
    s = Song.find_or_initialize_by(spotify_id: spotify_song.id)

    if s.persisted? == false
      s.name = spotify_song.name
      s.album = Album.get_album(spotify_song.album)
      s.spotify_id = spotify_song.id
      s.artists = spotify_song.artists.map do |spotify_artist|
        Artist.get_artist(spotify_artist)
      end
      s.save
    end

    return s
  end  
end
