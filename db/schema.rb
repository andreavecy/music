# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_01_22_171700) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.integer "popularity"
    t.date "release_date"
    t.integer "total_tracks"
    t.text "genres", default: [], array: true
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.integer "followers"
    t.text "genres", default: [], array: true
    t.string "image"
    t.string "name"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorite_tracks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_favorite_tracks_on_track_id"
    t.index ["user_id"], name: "index_favorite_tracks_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "image"
    t.string "description"
    t.integer "likes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.integer "disc_number"
    t.integer "duration_ms"
    t.string "name"
    t.string "preview_url"
    t.integer "track_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id"
    t.index ["album_id"], name: "index_tracks_on_album_id"
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "image"
    t.string "username", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "favorite_tracks", "tracks"
  add_foreign_key "favorite_tracks", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "tracks", "albums"
  add_foreign_key "tracks", "artists"
end
