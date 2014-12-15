class MsLocation < ActiveRecord::Base
  scope :region, ->(region) { where(region: region)}
  # scope :regions, ->(regions) { where(region: regions)}
  scope :rncs, ->(rncs) { where(rncname: rncs)}
end
