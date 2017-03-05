require 'test_helper'

class PlaylistVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @playlist_version = playlist_versions(:one)
  end

  test "should get index" do
    get playlist_versions_url, as: :json
    assert_response :success
  end

  test "should create playlist_version" do
    assert_difference('PlaylistVersion.count') do
      post playlist_versions_url, params: { playlist_version: { playlist_id: @playlist_version.playlist_id, spotify_snapshot_id: @playlist_version.spotify_snapshot_id } }, as: :json
    end

    assert_response 201
  end

  test "should show playlist_version" do
    get playlist_version_url(@playlist_version), as: :json
    assert_response :success
  end

  test "should update playlist_version" do
    patch playlist_version_url(@playlist_version), params: { playlist_version: { playlist_id: @playlist_version.playlist_id, spotify_snapshot_id: @playlist_version.spotify_snapshot_id } }, as: :json
    assert_response 200
  end

  test "should destroy playlist_version" do
    assert_difference('PlaylistVersion.count', -1) do
      delete playlist_version_url(@playlist_version), as: :json
    end

    assert_response 204
  end
end
