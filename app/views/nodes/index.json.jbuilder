json.array!(@nodes) do |node|
  json.extract! node, :id, :name, :node_type, :status
  json.url node_url(node, format: :json)
end
