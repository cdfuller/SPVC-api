class SpotifyWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    sp = user.spotify_user
    playlist_limit, playlist_offset = 50, 0
    playlists = sp.playlists(limit: playlist_limit, offset: playlist_offset)

    while playlists.count == (playlist_limit + playlist_offset)
      playlist_offset += playlist_limit
      playlists += sp.playlists(limit: playlist_limit, offset: playlist_offset)
    end

    # Reauthenticate so we can access private playlists that we don't own.
    # ex. Discover Weekly by Spotify 
    RSpotify::authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_SECRET"])

    playlists.each do |spotify_playlist|
      p = Playlist.get_playlist(spotify_playlist)

      user.playlists << p

      if p.up_to_date?(spotify_playlist) == false
        p.add_version(spotify_playlist)
      end
    end
  end
end
