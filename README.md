# SPVC - Spotify Playlist Version Control

 SPVC is a tool to track updates to every Spotify playlist you follow. No more lost playlists!
 
 This is the backend API for the project.
 
## Setup

* Create the file `.env` in the root directory and add Spotify api access keys.

 ``` 
 	SPOTIFY_CLIENT_ID=<your-client-id>
 	SPOTIFY_SECRET=<your-secret>
 ```
 
 
* `bundle install `
* `rails db:create && rails db:migrate` 
* `redis-server start`
* `bundle exec sidekiq`
* `rails server`