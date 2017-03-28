# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170328033132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_artists", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_artists_on_album_id", using: :btree
    t.index ["artist_id"], name: "index_album_artists_on_artist_id", using: :btree
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artist_songs", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_songs_on_artist_id", using: :btree
    t.index ["song_id"], name: "index_artist_songs_on_song_id", using: :btree
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlist_songs", force: :cascade do |t|
    t.integer  "playlist_version_id"
    t.integer  "song_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["playlist_version_id"], name: "index_playlist_songs_on_playlist_version_id", using: :btree
    t.index ["song_id"], name: "index_playlist_songs_on_song_id", using: :btree
  end

  create_table "playlist_versions", force: :cascade do |t|
    t.integer  "playlist_id"
    t.string   "spotify_snapshot_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["playlist_id"], name: "index_playlist_versions_on_playlist_id", using: :btree
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.string   "spotify_owner_name"
    t.string   "image_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "songs", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["album_id"], name: "index_songs_on_album_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["playlist_id"], name: "index_subscriptions_on_playlist_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "spotify_hash"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "album_artists", "albums"
  add_foreign_key "album_artists", "artists"
  add_foreign_key "artist_songs", "artists"
  add_foreign_key "artist_songs", "songs"
  add_foreign_key "playlist_songs", "playlist_versions"
  add_foreign_key "playlist_songs", "songs"
  add_foreign_key "playlist_versions", "playlists"
  add_foreign_key "songs", "albums"
  add_foreign_key "subscriptions", "playlists"
  add_foreign_key "subscriptions", "users"
end
