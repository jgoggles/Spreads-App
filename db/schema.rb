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

ActiveRecord::Schema.define(version: 20170825225340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",      limit: 255
  end

  create_table "conferences", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "earned_badges", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.integer  "pick_set_id"
    t.integer  "pick_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_details", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.boolean  "is_home"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "date"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "sport",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues_pools", id: false, force: :cascade do |t|
    t.integer "league_id"
    t.integer "pool_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pick_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_id",  limit: 255
  end

  create_table "picks", force: :cascade do |t|
    t.float    "spread"
    t.integer  "result"
    t.integer  "game_id"
    t.integer  "pick_set_id"
    t.integer  "team_id"
    t.float    "over_under"
    t.boolean  "is_over"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "over_under_result"
    t.integer  "count"
  end

  create_table "pool_types", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "max_picks"
    t.integer  "min_picks"
    t.boolean  "spreads"
    t.boolean  "over_under"
    t.boolean  "is_tiebreaker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_same_game"
  end

  create_table "pool_users", force: :cascade do |t|
    t.integer  "pool_id"
    t.integer  "user_id"
    t.boolean  "pool_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "pools", force: :cascade do |t|
    t.integer  "pool_type_id"
    t.string   "name",                 limit: 255
    t.boolean  "free"
    t.integer  "cost"
    t.float    "first_place_payout"
    t.float    "second_place_payout"
    t.float    "third_place_payout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_id",            limit: 255
    t.boolean  "private"
    t.string   "password",             limit: 255
    t.integer  "max_players"
    t.integer  "min_players"
    t.integer  "year_id"
    t.float    "fourth_place_payout"
    t.float    "fifth_place_payout"
    t.float    "sixth_place_payout"
    t.float    "seventh_place_payout"
    t.float    "eighth_place_payout"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message"
    t.string   "username",   limit: 255
    t.integer  "item"
    t.string   "table",      limit: 255
    t.integer  "month",      limit: 2
    t.bigint   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "standings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "pushes"
    t.integer  "points"
    t.integer  "over_under_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pick_set_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "city",          limit: 255
    t.string   "nickname",      limit: 255
    t.integer  "league_id"
    t.integer  "conference_id"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo",          limit: 255
    t.string   "abbr",          limit: 255
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "pool_id"
    t.integer  "user_id"
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "hashed_id",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "favorite_nfl_team_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weeks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year_id"
  end

  create_table "years", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current"
  end

end
