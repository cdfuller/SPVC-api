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
* `redis-server`
* `bundle exec sidekiq`
* `rails server`

## Flow

* Create user
	* `POST` `user[email]` and `user[password]` to `/users`
	* Returns `JWT`

* Authenticate
	* Add `Authorization` header with the `JWT` as the value

* Connect Spotify
	* `GET /user` returns json for the user which includes the Spotify auth url 

[Resources](resources.md)
