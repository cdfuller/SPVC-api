class PlaylistVersionsController < ApplicationController
  before_action :set_playlist_version, only: [:show, :update, :destroy]

  # GET /playlist_versions
  def index
    @playlist_versions = PlaylistVersion.all

    render json: @playlist_versions
  end

  # GET /playlist_versions/1
  def show
    render json: @playlist_version
  end

  # POST /playlist_versions
  def create
    @playlist_version = PlaylistVersion.new(playlist_version_params)

    if @playlist_version.save
      render json: @playlist_version, status: :created, location: @playlist_version
    else
      render json: @playlist_version.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /playlist_versions/1
  def update
    if @playlist_version.update(playlist_version_params)
      render json: @playlist_version
    else
      render json: @playlist_version.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlist_versions/1
  def destroy
    @playlist_version.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_version
      @playlist_version = PlaylistVersion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def playlist_version_params
      params.require(:playlist_version).permit(:playlist_id, :spotify_snapshot_id)
    end
end
