json.array!(@users) do |user|
  json.extract! user, :id, :name, :department
  json.url user_url(user, format: :json)
end
