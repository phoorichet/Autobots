class Metric < ActiveRecord::Base
  belongs_to :service
  belongs_to :visualization

  has_many   :filters
  has_many   :vspecs
  has_many   :selectfs
end
