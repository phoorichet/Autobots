json.array!(@links) do |link|
  json.extract! link, :id, :source, :target, :status
  json.url link_url(link, format: :json)
end
