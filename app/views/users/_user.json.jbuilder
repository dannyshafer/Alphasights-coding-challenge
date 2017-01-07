json.extract! user, :id, :name, :website, :shortened_url, :created_at, :updated_at
json.url user_url(user, format: :json)