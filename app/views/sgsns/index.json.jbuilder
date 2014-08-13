json.array!(@sgsns) do |sgsn|
  json.extract! sgsn, :id, :name
  json.url sgsn_url(sgsn, format: :json)
end
