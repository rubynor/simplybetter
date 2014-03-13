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

ActiveRecord::Schema.define(version: 20140313092307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.string   "icon"
  end

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "idea_id"
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

  create_table "idea_groups", force: true do |t|
    t.integer "application_id"
  end

  create_table "idea_subscriptions", force: true do |t|
    t.integer  "idea_id"
    t.string   "subscriber_type"
    t.integer  "subscriber_id"
    t.string   "subscriber_from_type"
    t.integer  "subscriber_from_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "application_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "votes_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "idea_group_id"
    t.boolean  "completed",      default: false
  end

  create_table "notifications", force: true do |t|
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "action_type"
    t.integer  "action_id"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action_attribute"
    t.string   "action_attribute_changed_by_type"
    t.integer  "action_attribute_changed_by_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "vote_receiver_id"
    t.string   "vote_receiver_type"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "voter_type"
    t.integer  "voter_id"
  end

end
