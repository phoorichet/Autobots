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
end
