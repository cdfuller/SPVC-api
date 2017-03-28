require 'sidekiq/web'

Rails.application.routes.draw do
  resources :subscriptions
  resources :songs
  resources :artists
  resources :albums
  resources :playlist_versions
  resources :playlists
  resources :users

  get '/auth/spotify/callback', to: 'users#spotify_callback'
  get '/auth/spotify/login', to: 'users#spotify_auth'
  post '/authenticate', to: 'authentication#authenticate'

  put '/spotify/process', to: 'spotify#update'

  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
