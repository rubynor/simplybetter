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

ActiveRecord::Schema.define(version: 20130828131451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "feature_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "votes_count",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feature_groups", force: true do |t|
    t.integer "application_id"
  end

  create_table "features", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "application_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "votes_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feature_group_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "vote_receiver_id"
    t.string   "vote_receiver_type"
    t.string   "voter_email"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
