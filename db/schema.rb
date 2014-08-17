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

ActiveRecord::Schema.define(version: 20140816171610) do

  create_table "bookings", force: true do |t|
    t.integer  "user_id"
    t.integer  "mansion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["mansion_id"], name: "index_bookings_on_mansion_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "mansion_amenities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mansions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "region"
    t.string   "city"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "square_feet"
    t.date     "available_date"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "source"
    t.string   "country"
    t.text     "photo_url"
    t.string   "price"
  end

  create_table "personality_trait_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "personality_trait_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personality_traits", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pledges", force: true do |t|
    t.integer "user_id"
    t.integer "mansion_id"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "total_price"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
