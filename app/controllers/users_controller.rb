class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :spotify_callback]
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:create]

  # https://accounts.spotify.com/authorize?client_id=5c97b616cf644c148bc35b47ffdf2cab&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Fspotify%2Fcallback&response_type=code&scope=user-read-email+playlist-modify-public+user-library-read+playlist-read-private+playlist-read-collaborative+user-top-read&state=e9aaeb7c32b97303e465f0f4571a7bbe

  def spotify_auth
    client_id =  ENV['SPOTIFY_CLIENT_ID']
    callback_url = Rack::Utils.escape("#{ENV['CALLBACK_HOST']}/auth/spotify/callback")
    scope = 'user-read-email playlist-modify-public user-library-read playlist-read-private playlist-read-collaborative user-top-read'.tr(' ', '+')
    state = @current_user.auth_token
    auth_url = "https://accounts.spotify.com/authorize?client_id=#{client_id}&redirect_uri=#{callback_url}&response_type=code&scope=#{scope}&state=#{state}"
    redirect_to auth_url
  end

  def spotify_callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = User.find_by(auth_token: params['state'])
    user.spotify_hash = spotify_user.to_hash
    user.save
    render json: spotify_user.to_hash
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
