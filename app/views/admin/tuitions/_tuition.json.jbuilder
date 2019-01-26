json.extract! tuition, :id, :description, :day, :amount, :email_id, :created_at, :updated_at
json.url admin_tuition_url(tuition, format: :json)
