class User < ApplicationRecord
  serialize :spotify_hash

  has_many :subscriptions
  has_many :playlists, through: :subscriptions

  has_secure_password

  before_create do
    self.auth_token = SecureRandom.hex
  end

  def spotify_user
    @_spotify_user ||= RSpotify::User.new(spotify_hash)
  end

  def spotify_auth_url
    client_id = ENV["SPOTIFY_CLIENT_ID"]
    callback_url = Rack::Utils.escape("#{ENV['CALLBACK_HOST']}/auth/spotify/callback")
    scope = 'user-read-email playlist-modify-public user-library-read playlist-read-private playlist-read-collaborative user-top-read'.tr(' ', '+')
    state = auth_token
    "https://accounts.spotify.com/authorize?client_id=#{client_id}&redirect_uri=#{callback_url}&response_type=code&scope=#{scope}&state=#{state}"
  end
end
