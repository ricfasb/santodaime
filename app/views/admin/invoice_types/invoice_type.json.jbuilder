json.extract! invoice_type, :id, :description, :created_at, :updated_at
json.url admin_invoice_type_url(invoice_type, format: :json)
