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

ActiveRecord::Schema.define(version: 2019_05_11_075040) do

  create_table "accounts", force: :cascade do |t|
    t.string "guid"
    t.string "name"
    t.string "uid"
    t.string "password"
  end

  create_table "posts", force: :cascade do |t|
    t.string "guid"
    t.string "account_guid", null: false
    t.text "code", null: false
    t.text "image", null: false
    t.string "name"
    t.boolean "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reset_password_requests", force: :cascade do |t|
    t.string "guid"
    t.string "account_guid", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "guid", null: false
    t.string "account_guid"
    t.string "session_id"
    t.datetime "login_at"
    t.datetime "expire_at"
    t.boolean "login"
  end

end
