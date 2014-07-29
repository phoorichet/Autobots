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

ActiveRecord::Schema.define(version: 20140729040104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metric_https", force: true do |t|
    t.string   "region"
    t.string   "location"
    t.string   "rncname"
    t.string   "mobile_code"
    t.string   "imei"
    t.string   "imsi"
    t.string   "script_name"
    t.string   "apn"
    t.string   "serviceinfo"
    t.integer  "attempt"
    t.integer  "success"
    t.float    "http_succ_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_time"
  end

  create_table "metric_pings", force: true do |t|
    t.string   "region"
    t.string   "location"
    t.string   "rncname"
    t.string   "mobile_code"
    t.string   "imei"
    t.string   "imsi"
    t.string   "target_ip"
    t.integer  "attempt"
    t.float    "percent_loss"
    t.float    "avg_packet_loss_rate"
    t.float    "avg_rtt_succ_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_time"
  end

  create_table "metric_speedtests", force: true do |t|
    t.string   "region"
    t.string   "location"
    t.string   "rncname"
    t.string   "mobile_code"
    t.string   "imei"
    t.string   "imsi"
    t.string   "script_name"
    t.string   "set_server_name"
    t.integer  "attempt"
    t.integer  "download_1mbps"
    t.float    "speedtest_dl_1m_rate"
    t.integer  "download_2mbps"
    t.float    "speedtest_dl_2m_rate"
    t.integer  "upload_300kbps"
    t.float    "speedtest_ul_300k_rate"
    t.integer  "upload_1mkbps"
    t.float    "speedtest_ul_1m_rate"
    t.integer  "latency_300ms"
    t.float    "speedtest_lt_300k_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_time"
  end

  create_table "metric_youtubes", force: true do |t|
    t.string   "region"
    t.string   "location"
    t.string   "rncname"
    t.string   "mobile_code"
    t.string   "imei"
    t.string   "imsi"
    t.string   "script_name"
    t.integer  "attempt"
    t.integer  "success"
    t.integer  "quality"
    t.float    "youtube_succ_rate"
    t.float    "youtube_qual_rate"
    t.float    "youtube_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_time"
  end

  create_table "metrics", force: true do |t|
    t.string   "name"
    t.string   "settings"
    t.string   "model_name"
    t.string   "attr"
    t.string   "transform"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "setttings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "department"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visualizations", force: true do |t|
    t.string   "name"
    t.string   "view_path"
    t.string   "setting"
    t.string   "type_viz"
    t.string   "config_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
