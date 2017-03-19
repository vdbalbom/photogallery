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

ActiveRecord::Schema.define(version: 20170319223706) do

  create_table "admins", force: :cascade do |t|
    t.string   "login"
    t.string   "site_title"
    t.string   "site_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "password_digest"
    t.index ["login"], name: "index_admins_on_login", unique: true
  end

  create_table "contributors", force: :cascade do |t|
    t.string   "login"
    t.string   "name"
    t.string   "description"
    t.string   "email"
    t.string   "facebook_link"
    t.string   "instagram_link"
    t.string   "tumblr_link"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "password_digest"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.index ["email"], name: "index_contributors_on_email", unique: true
    t.index ["login"], name: "index_contributors_on_login", unique: true
    t.index ["name"], name: "index_contributors_on_name", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "contributor_id"
    t.index ["contributor_id"], name: "index_photos_on_contributor_id"
  end

  create_table "taggers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.index ["photo_id"], name: "index_taggers_on_photo_id"
    t.index ["tag_id"], name: "index_taggers_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

end
