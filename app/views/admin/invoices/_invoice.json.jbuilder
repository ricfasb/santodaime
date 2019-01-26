json.extract! invoice, :id, :description, :due_date, :amount, :created_at, :updated_at
json.url admin_invoice_url(invoice, format: :json)
