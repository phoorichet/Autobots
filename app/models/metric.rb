class Metric < ActiveRecord::Base
  belongs_to :service
  belongs_to :visualization

  has_many   :filters
end
