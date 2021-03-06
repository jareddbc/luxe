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

ActiveRecord::Schema.define(version: 20150917205721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string   "key"
    t.integer  "hotel_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "room_number"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "guests", ["hotel_id"], name: "index_guests_on_hotel_id", using: :btree

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.text     "amenities"
    t.string   "calendar_id"
    t.boolean  "terms",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "image"
    t.text     "desciption"
    t.integer  "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["menu_id"], name: "index_items_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "hotel_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "menus", ["hotel_id"], name: "index_menus_on_hotel_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "hotel_id"
    t.datetime "starts_at_date"
    t.datetime "starts_at_time"
    t.string   "title"
    t.text     "special_request"
    t.integer  "guest_id"
    t.integer  "menu_id"
    t.boolean  "completed",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "services", ["guest_id"], name: "index_services_on_guest_id", using: :btree
  add_index "services", ["hotel_id"], name: "index_services_on_hotel_id", using: :btree

  add_foreign_key "guests", "hotels"
  add_foreign_key "items", "menus"
  add_foreign_key "menus", "hotels"
  add_foreign_key "services", "guests"
  add_foreign_key "services", "hotels"
end
