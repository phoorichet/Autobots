class TimeConfig < ActiveRecord::Base
  default_scope { order('order_id ASC') }
end
