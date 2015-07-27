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

ActiveRecord::Schema.define(version: 20150727094623) do

  create_table "cart_products", force: :cascade do |t|
    t.integer  "cart_id",    limit: 4,             null: false
    t.integer  "product_id", limit: 4
    t.integer  "number",     limit: 4, default: 1
    t.integer  "price",      limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.decimal  "total_price",               precision: 10, default: 0
    t.string   "status",      limit: 255,                  default: "Prosess"
    t.string   "full_name",   limit: 255
    t.integer  "phone",       limit: 4
    t.string   "email",       limit: 255
    t.text     "address",     limit: 65535
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 1000,  null: false
    t.string   "image",       limit: 1000
    t.text     "description", limit: 65535
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "category_id", limit: 4
    t.string   "image",       limit: 1000
    t.string   "name",        limit: 1000,                 null: false
    t.decimal  "price",                     precision: 10, null: false
    t.text     "description", limit: 65535
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
