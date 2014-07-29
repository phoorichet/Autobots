json.array!(@visualizations) do |visualization|
  json.extract! visualization, :id, :name, :view_path, :setting, :type_viz, :config_file
  json.url visualization_url(visualization, format: :json)
end
