json.array!(@ms_rnc_sgsns) do |ms_rnc_sgsn|
  json.extract! ms_rnc_sgsn, :id, :rnc_name, :sgsn_name
  json.url ms_rnc_sgsn_url(ms_rnc_sgsn, format: :json)
end
