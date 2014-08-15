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

ActiveRecord::Schema.define(version: 20140815182033) do

  create_table "identities", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.text     "birthdate"
    t.text     "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mansions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "continent"
    t.string   "city"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "square_feet"
    t.date     "available_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "price"
  end

  create_table "pledges", force: true do |t|
    t.integer  "guest_id"
    t.integer  "mansion_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pledges", ["guest_id"], name: "index_pledges_on_guest_id"
  add_index "pledges", ["mansion_id"], name: "index_pledges_on_mansion_id"

end
