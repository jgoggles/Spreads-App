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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110906032447) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "conferences", :force => true do |t|
    t.string   "name"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "divisions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "earned_badges", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.integer  "pick_set_id"
    t.integer  "pick_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_details", :force => true do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.boolean  "is_home"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.datetime "date"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.string   "sport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues_pools", :id => false, :force => true do |t|
    t.integer "league_id"
    t.integer "pool_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pick_sets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_id"
  end

  create_table "picks", :force => true do |t|
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
  end

  create_table "pool_types", :force => true do |t|
    t.string   "name"
    t.integer  "max_picks"
    t.integer  "min_picks"
    t.boolean  "spreads"
    t.boolean  "over_under"
    t.boolean  "is_tiebreaker"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_users", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "user_id"
    t.boolean  "pool_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
  end

  create_table "pools", :force => true do |t|
    t.integer  "pool_type_id"
    t.string   "name"
    t.boolean  "free"
    t.integer  "cost"
    t.integer  "first_place_payout"
    t.integer  "second_place_payout"
    t.integer  "third_place_payout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_id"
    t.boolean  "private"
    t.string   "password"
    t.integer  "max_players"
    t.integer  "min_players"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "standings", :force => true do |t|
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
  end

  create_table "teams", :force => true do |t|
    t.string   "city"
    t.string   "nickname"
    t.integer  "league_id"
    t.integer  "conference_id"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "hashed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "favorite_nfl_team_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weeks", :force => true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
