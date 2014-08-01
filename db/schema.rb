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

ActiveRecord::Schema.define(version: 20140801085346) do

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

  create_table "applications_customers", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "application_id"
  end

  add_index "applications_customers", ["application_id", "customer_id"], name: "index_applications_customers_on_application_id_and_customer_id", using: :btree
  add_index "applications_customers", ["customer_id"], name: "index_applications_customers_on_customer_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "idea_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "votes_count",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",      default: true
  end

  add_index "comments", ["creator_id", "creator_type"], name: "index_comments_on_creator_id_and_creator_type", using: :btree
  add_index "comments", ["idea_id"], name: "comments_idea_id_ix", using: :btree

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
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

  add_index "idea_subscriptions", ["idea_id"], name: "idea_subscriptions_idea_id_ix", using: :btree
  add_index "idea_subscriptions", ["subscriber_from_id", "subscriber_from_type"], name: "idea_subscriptions_from_poly_ix", using: :btree
  add_index "idea_subscriptions", ["subscriber_id", "subscriber_type"], name: "index_idea_subscriptions_on_subscriber_id_and_subscriber_type", using: :btree

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
    t.boolean  "visible",        default: true
  end

  add_index "ideas", ["application_id"], name: "ideas_application_id_ix", using: :btree
  add_index "ideas", ["creator_id", "creator_type"], name: "index_ideas_on_creator_id_and_creator_type", using: :btree

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
    t.integer  "application_id"
  end

  add_index "notifications", ["action_attribute_changed_by_id", "action_attribute_changed_by_type"], name: "notifications_action_attribute_poly_ix", using: :btree
  add_index "notifications", ["action_id", "action_type"], name: "index_notifications_on_action_id_and_action_type", using: :btree
  add_index "notifications", ["application_id"], name: "notification_application_id_ix", using: :btree
  add_index "notifications", ["recipient_id", "recipient_type"], name: "index_notifications_on_recipient_id_and_recipient_type", using: :btree
  add_index "notifications", ["subject_id", "subject_type"], name: "index_notifications_on_subject_id_and_subject_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
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

  add_index "votes", ["vote_receiver_id", "vote_receiver_type"], name: "index_votes_on_vote_receiver_id_and_vote_receiver_type", using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

  create_table "widget_customers", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "application_id"
  end

  add_index "widget_customers", ["application_id", "customer_id"], name: "index_widget_customers_on_application_id_and_customer_id", using: :btree
  add_index "widget_customers", ["customer_id"], name: "index_widget_customers_on_customer_id", using: :btree

  create_table "widget_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "application_id"
  end

  add_index "widget_users", ["application_id", "user_id"], name: "index_widget_users_on_application_id_and_user_id", using: :btree
  add_index "widget_users", ["user_id"], name: "index_widget_users_on_user_id", using: :btree

end
