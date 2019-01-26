json.extract! checkin, :id, :person_id, :company_id, :created_at, :updated_at
json.url checkin_url(checkin, format: :json)
