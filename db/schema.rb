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

ActiveRecord::Schema.define(version: 20130915223142) do

  create_table "blacklists", force: true do |t|
    t.integer  "user_id"
    t.string   "episodes",   array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "podcast_id"
    t.string   "name"
    t.string   "cover"
    t.string   "link"
    t.string   "description"
    t.integer  "sc_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
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
