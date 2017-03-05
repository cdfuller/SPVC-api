class Playlist < ApplicationRecord
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions
  has_many :versions, class_name: 'PlaylistVersion'

  def self.get_playlist(spotify_playlist)
    p = Playlist.find_or_initialize_by(spotify_id: spotify_playlist.id)

    if p.persisted? == false
      p.name = spotify_playlist.name
      p.spotify_owner_name = spotify_playlist.owner.id
      if spotify_playlist.images.any?
        p.image_url = spotify_playlist.images[0]['url']
      else
        puts "/n" * 20
        puts "NO IMAGE"
        puts "/n" * 20
      end
      p.save
    end

    return p
  end

  def up_to_date?(spotify_playlist)
    return versions.last.spotify_snapshot_id == spotify_playlist.snapshot_id if versions.any?
    return false
  end

  def add_version(spotify_playlist)
    pv = versions.build

    tracks_limit, tracks_offset = 100, 0
    tracks = spotify_playlist.tracks(limit: tracks_limit, offset: tracks_offset)

    while tracks.count == (tracks_limit + tracks_offset)
      tracks_offset += tracks_limit
      tracks += spotify_playlist.tracks(limit: tracks_limit, offset: tracks_offset)
    end

    tracks.each do |track|
      ps = pv.playlist_songs.build
      ps.song = Song.get_song(track)
      ps.save
    end
    pv.spotify_snapshot_id = spotify_playlist.snapshot_id
    return pv.save
  end
end
