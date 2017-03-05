class PlaylistVersion < ApplicationRecord
  belongs_to :playlist
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
end
