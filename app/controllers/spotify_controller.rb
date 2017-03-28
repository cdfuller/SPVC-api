class SpotifyController < ApplicationController

  def update
    puts "\n" * 30
    SpotifyWorker.perform_async(current_user.id)
  end
end
