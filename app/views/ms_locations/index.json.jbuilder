json.array!(@ms_locations) do |ms_location|
  json.extract! ms_location, :id, :mobile_code, :mini_box, :imei, :serial_no, :mobile_no, :region, :rncname, :building_id, :location
  json.url ms_location_url(ms_location, format: :json)
end
