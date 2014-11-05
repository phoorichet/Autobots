class MsLocation < ActiveRecord::Base
  scope :region, ->(region) { where("region =?", region)}
  scope :rncs, ->(rncs) { where(rncname: rncs)}
end
