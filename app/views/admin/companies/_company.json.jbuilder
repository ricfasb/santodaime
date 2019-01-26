json.extract! company, :id, :name, :telephone, :address_id, :created_at, :updated_at
json.url admin_company_url(company, format: :json)
