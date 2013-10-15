# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131015204543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blacklists", force: true do |t|
    t.integer  "user_id"
    t.string   "episodes",   default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_podcasts", force: true do |t|
    t.integer "category_id"
    t.integer "podcast_id"
  end

  add_index "categories_podcasts", ["category_id"], name: "index_categories_podcasts_on_category_id", using: :btree
  add_index "categories_podcasts", ["podcast_id"], name: "index_categories_podcasts_on_podcast_id", using: :btree

  create_table "episodes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "podcast_id"
    t.text     "name"
    t.string   "cover"
    t.text     "link"
    t.text     "description"
    t.integer  "sc_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.text     "summary"
    t.text     "subtitle"
    t.string   "explicit"
    t.string   "duration"
    t.boolean  "needs_download"
  end

  add_index "episodes", ["podcast_id"], name: "index_episodes_on_podcast_id", using: :btree

  create_table "podcasts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "description"
    t.string   "website"
    t.string   "language"
    t.string   "subtitle"
    t.string   "author"
    t.text     "summary"
    t.string   "copyright"
    t.string   "explicit"
    t.string   "itunes_feed"
    t.string   "rss_feed"
  end

  add_index "podcasts", ["user_id"], name: "index_podcasts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.integer  "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "avatar_url"
    t.boolean  "subscribed",   default: false
    t.string   "stripe_token"
  end

end
