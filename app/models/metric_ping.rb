require "locke/config/mixin"

class MetricPing < ActiveRecord::Base
  include Locke::Config::Mixin
  include Locke::Dsl::Qdsl
  
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
  scope :apn,      ->(apn) { apn == "All" ? nil : where("apn = ?", apn) }
  scope :sgsn,      ->(sgsn) { sgsn == "All" ? nil : where(rncname: Sgsn.where(name: sgsn).first.rncs.map {|d| d.name}) }

  set_default :export_attr, [ :attempt, :percent_loss, :avg_packet_loss_rate, 
                              :avg_rtt_succ_rate, :avg_rssi, :avg_rxlev, :avg_ecio,
                              :speedtest_dl_1m_rate, :download_2mbps,
                              :speedtest_dl_2m_rate, :upload_300kbps,
                              :speedtest_ul_300k_rate, :upload_1mkbps,
                              :speedtest_ul_1m_rate, :latency_300ms,
                              :speedtest_lt_300k_rate ]

end
