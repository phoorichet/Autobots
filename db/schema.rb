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

ActiveRecord::Schema.define(version: 20141105083114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "filters", force: true do |t|
    t.string   "description"
    t.integer  "metric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "operand"
    t.string   "operation"
    t.string   "field"
    t.string   "operand_type"
  end

  create_table "links", force: true do |t|
    t.string   "source"
    t.string   "target"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_type"
  end

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
    t.string   "sgsn_name"
    t.string   "site"
    t.string   "cell_id"
    t.string   "lac"
    t.string   "ip"
    t.float    "lat"
    t.float    "lon"
    t.float    "connecting_time"
    t.float    "avg_rssi"
    t.float    "avg_rxlev"
    t.float    "avg_ecio"
    t.float    "throughput_download_app"
    t.float    "throughput_download_rlc"
  end

  add_index "metric_https", ["apn"], name: "index_metric_https_on_apn", using: :btree
  add_index "metric_https", ["date_time"], name: "index_metric_https_on_date_time", using: :btree
  add_index "metric_https", ["serviceinfo"], name: "index_metric_https_on_serviceinfo", using: :btree
  add_index "metric_https", ["sgsn_name"], name: "index_metric_https_on_sgsn_name", using: :btree

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
    t.string   "apn"
    t.string   "site"
    t.string   "ip"
    t.string   "technology"
    t.string   "sgsn_name"
    t.string   "script_name"
    t.float    "lat"
    t.float    "lon"
    t.string   "cell_id"
    t.string   "lac"
    t.float    "avg_rssi"
    t.float    "avg_rxlev"
    t.float    "avg_ecio"
    t.string   "target_host"
    t.integer  "packet_sent"
    t.integer  "packet_received"
    t.integer  "packet_lost"
    t.float    "rtt_min"
    t.float    "rtt_avg"
    t.float    "rtt_max"
    t.float    "rtt_mdev"
    t.integer  "success"
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
    t.string   "apn"
    t.string   "site"
    t.integer  "server_id"
    t.string   "server_name"
    t.string   "internal_ip"
    t.string   "external_ip"
    t.string   "sgsn_name"
    t.float    "lat"
    t.float    "lon"
    t.string   "cell_id"
    t.string   "lac"
    t.string   "technology"
    t.float    "avg_rssi"
    t.float    "avg_rxlev"
    t.float    "avg_ecio"
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
    t.string   "apn"
    t.string   "site"
    t.string   "ip"
    t.string   "technology"
    t.string   "sgsn_name"
    t.float    "lat"
    t.float    "lon"
    t.string   "cell_id"
    t.string   "lac"
    t.float    "avg_rssi"
    t.float    "avg_rxlev"
    t.float    "avg_ecio"
  end

  create_table "metrics", force: true do |t|
    t.string   "name"
    t.string   "settings"
    t.string   "attr"
    t.string   "transform"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visualization_id"
    t.string   "resource_name"
    t.string   "unit"
    t.string   "mapf"
    t.string   "reducef"
    t.string   "groupf"
    t.string   "reducef_init_value"
  end

  create_table "ms_locations", force: true do |t|
    t.string   "mobile_code"
    t.integer  "mini_box"
    t.string   "imei"
    t.string   "serial_no"
    t.string   "mobile_no"
    t.string   "region"
    t.string   "rncname"
    t.string   "building_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ms_rnc_sgsns", force: true do |t|
    t.string   "rnc_name"
    t.string   "sgsn_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "node_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coverage_region"
    t.string   "site"
  end

  create_table "raw_https", force: true do |t|
    t.float    "connecting_time_1"
    t.float    "time_to_first_byte_1"
    t.string   "result_1"
    t.string   "result_detail_1"
    t.string   "imei"
    t.string   "imsi"
    t.string   "script_name"
    t.string   "service"
    t.string   "service_info"
    t.float    "agv_rssi"
    t.float    "avg_rxlev"
    t.float    "avg_ecio"
    t.integer  "cell_id"
    t.integer  "lac"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.float    "duration_time"
    t.integer  "data_download_transfer"
    t.float    "max_download"
    t.float    "max_download_overall"
    t.float    "min_download"
    t.float    "throughput_download_ip"
    t.float    "throughput_download_app"
    t.float    "throughput_download_rlc"
    t.string   "result"
    t.float    "lat"
    t.float    "lon"
    t.string   "apn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_pings", force: true do |t|
    t.string   "imei"
    t.string   "imsi"
    t.string   "technology"
    t.datetime "datetime"
    t.integer  "packet_sent"
    t.integer  "packet_received"
    t.integer  "packet_lost"
    t.float    "rtt_min"
    t.float    "rtt_max"
    t.float    "rtt_mdev"
    t.string   "apn"
    t.integer  "apn_mcc"
    t.integer  "apn_mnc"
    t.string   "ip"
    t.integer  "lac"
    t.integer  "cell_id"
    t.string   "script_name"
    t.integer  "packet_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_speedtests", force: true do |t|
    t.string   "imei"
    t.string   "imsi"
    t.string   "technology"
    t.datetime "datetime"
    t.float    "download"
    t.float    "upload"
    t.integer  "latency"
    t.integer  "server_id"
    t.string   "server_name"
    t.float    "avg_ecio"
    t.float    "avg_rssi"
    t.integer  "mcc"
    t.integer  "lac"
    t.integer  "cell_id"
    t.string   "script_name"
    t.string   "operator"
    t.string   "result"
    t.integer  "set_server_id"
    t.string   "set_server_name"
    t.string   "apn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_youtubes", force: true do |t|
    t.string   "imei"
    t.string   "imsi"
    t.string   "script_name"
    t.string   "operator"
    t.string   "technology"
    t.float    "avg_rssi"
    t.float    "avg_rxlen"
    t.float    "avg_ecio"
    t.integer  "cell_id"
    t.integer  "lac"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.float    "duration_time"
    t.integer  "data_download_transfer"
    t.float    "throughput_download_app"
    t.float    "throughput_download_rlc"
    t.string   "result"
    t.string   "result_detail"
    t.integer  "youtube_video_duration"
    t.float    "lat"
    t.float    "lon"
    t.string   "apn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rncs", force: true do |t|
    t.string   "name"
    t.integer  "sgsn_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selectfs", force: true do |t|
    t.string   "field"
    t.boolean  "selected"
    t.integer  "metric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "setttings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "model_name"
  end

  create_table "sgsns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_configs", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "start"
    t.string   "time_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stop"
    t.integer  "interval"
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

  create_table "vspecs", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "metric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
