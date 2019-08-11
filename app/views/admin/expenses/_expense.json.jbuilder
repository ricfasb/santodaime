json.extract! expense, :id, :company_id, :description, :observation, :provider, :amount, :created_at, :updated_at
json.url expense_url(expense, format: :json)
