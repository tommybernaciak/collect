json.array!(@users) do |user|
  json.extract! user, :nick, :email
  json.url user_url(user, format: :json)
end
