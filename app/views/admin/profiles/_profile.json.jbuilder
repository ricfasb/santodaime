json.extract! profile, :id, :description, :created_at, :updated_at
json.url profile_url(profile, format: :json)
