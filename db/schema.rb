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

ActiveRecord::Schema.define(version: 20150310145025) do

  create_table "coubs", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "visibility_type"
    t.string   "tags"
    t.string   "permalink"
    t.string   "coub_id"
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coubs", ["user_id"], name: "index_coubs_on_user_id"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "auth_token"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
