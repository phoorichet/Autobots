class MetricHttp < ActiveRecord::Base
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
  scope :apn,      ->(apn) { apn == "All" ? nil : where("apn = ?", apn) }
  scope :sgsn,      ->(sgsn) { sgsn == "All" ? nil : where(rncname: Sgsn.where(name: "3SGSNBPL1H").first.rncs.map {|d| d.name}) }

end
