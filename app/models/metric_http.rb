require "rockey/config/mixin"
require "rockey/scope/fsquare"

class MetricHttp < ActiveRecord::Base
  include Rockey::Config::Mixin
  include Rockey::Scope::Fsquare
  # Service scopes
  scope :instagram, -> { where("serviceinfo = ?", "INSTAGRAM") }
  scope :twitter,   -> { where("serviceinfo = ?", "TWITTER")   }
  scope :facebook,  -> { where("serviceinfo = ?", "FACEBOOK")  }

  # Filter scopes
  scope :east,      -> { where("region = ?", "East") }
  scope :northeast, -> { where("region = ?", "Northeast") }
  scope :north,     -> { where("region = ?", "North") }
  scope :south,     -> { where("region = ?", "South") }
  scope :central,   -> { where("region = ?", "Central") }
  scope :bankgkok,  -> { where("region = ?", "Bangkok") }
  scope :asc_date_time,       -> { order(date_time: :asc) }
  scope :start,     ->(timestamp) { where("date_time >= ?", timestamp) }
  scope :stop,      ->(timestamp) { where("date_time < ?", timestamp) }
  scope :region,    ->(region) { region == "All" ? nil : where("region = ?", region) }
  scope :site,      ->(site) { site == "All" ? nil : where("apn like ?", "%#{site}%") }
  scope :apn,       ->(apn) { apn == "All" ? nil : where("apn = ?", apn) }
  scope :sgsn,      ->(sgsn) { sgsn == "All" ? nil : where(sgsn_name: sgsn) }
  scope :rnc,       ->(rnc) { rnc == "All" ? nil : where(rncname: rnc) }
  # scope :ggsn,      ->(ggsn) { ggsn == "All" ? nil : where(ggsn_name: ggsn) }
  
  # Tell the front-end which attributes are measurable
  set_default :export_attr, [:throughput_download_app, :throughput_download_rlc, :avg_rssi,
                            :avg_rxlev, :avg_ecio, :connecting_time, :attempt, :success, 
                            :http_succ_rate]

  # export_filter : TODO

end
