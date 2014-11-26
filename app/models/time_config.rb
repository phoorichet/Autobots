class TimeConfig < ActiveRecord::Base
  # Make it odered by order_id so that the GUI knows how to arrage the list
  default_scope { order('order_id ASC') }
end
