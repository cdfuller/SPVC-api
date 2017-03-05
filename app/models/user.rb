class User < ApplicationRecord
  serialize :spotify_hash

  has_many :subscriptions, class_name: 'Subscribe'
  has_many :playlists, through: :subscriptions

  def spotify_user
    @_spotify_user ||= RSpotify::User.new(spotify_hash)
  end
end
