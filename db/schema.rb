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

ActiveRecord::Schema.define(version: 20170803202223) do

  create_table "bands", force: :cascade do |t|
    t.integer "position_id"
    t.integer "internal_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["internal_level_id"], name: "index_bands_on_internal_level_id"
    t.index ["position_id"], name: "index_bands_on_position_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "company_type"
    t.string "picture"
    t.string "industry"
    t.string "location"
  end

  create_table "internal_levels", force: :cascade do |t|
    t.integer "company_id"
    t.integer "position_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_internal_levels_on_company_id"
    t.index ["position_id"], name: "index_internal_levels_on_position_id"
  end

  create_table "oauth_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "image_url"
    t.string "profile_url"
    t.string "access_token"
    t.text "raw_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauth_accounts_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "job_expectation"
    t.decimal "avg_yrs_exp"
    t.text "criteria_for_next_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text "promotion_criteria"
    t.integer "user_id"
    t.integer "company_id"
    t.integer "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "internal_level_id"
    t.integer "you_report_to_id"
    t.integer "who_reports_to_you_id"
    t.index ["company_id"], name: "index_profiles_on_company_id"
    t.index ["internal_level_id"], name: "index_profiles_on_internal_level_id"
    t.index ["position_id"], name: "index_profiles_on_position_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
    t.index ["who_reports_to_you_id"], name: "index_profiles_on_who_reports_to_you_id"
    t.index ["you_report_to_id"], name: "index_profiles_on_you_report_to_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "reporter_id"
    t.integer "reported_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.index ["profile_id"], name: "index_relationships_on_profile_id"
    t.index ["reported_id"], name: "index_relationships_on_reported_id"
    t.index ["reporter_id", "reported_id"], name: "index_relationships_on_reporter_id_and_reported_id", unique: true
    t.index ["reporter_id"], name: "index_relationships_on_reporter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "provider"
    t.integer "oauth_id"
    t.string "uid"
    t.string "picture"
    t.datetime "last_login"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
