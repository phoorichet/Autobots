class Metric < ActiveRecord::Base
  belongs_to :service
  belongs_to :visualization
end
