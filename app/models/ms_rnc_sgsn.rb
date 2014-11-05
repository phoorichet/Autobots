class MsRncSgsn < ActiveRecord::Base
  scope :sgsn, ->(sgsn) { where("sgsn_name =?", sgsn)}
end
