class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_url

  def hello
    "world"
  end

  def auth_url
    client_id =  ENV["SPOTIFY_CLIENT_ID"]
    callback_url = Rack::Utils.escape("#{ENV['CALLBACK_HOST']}/auth/spotify/callback")
    scope = 'user-read-email playlist-modify-public user-library-read playlist-read-private playlist-read-collaborative user-top-read'.tr(' ', '+')
    state = object.auth_token
    auth_uri = "https://accounts.spotify.com/authorize?client_id=#{client_id}&redirect_uri=#{callback_url}&response_type=code&scope=#{scope}&state=#{state}"
  end
end
