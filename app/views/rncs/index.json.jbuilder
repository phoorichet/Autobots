json.array!(@rncs) do |rnc|
  json.extract! rnc, :id, :name, :sgsn_id
  json.url rnc_url(rnc, format: :json)
end
