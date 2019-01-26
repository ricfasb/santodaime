json.extract! payment, :id, :person_id, :invoice_id, :pay_day, :pay_amount, :discount, :obs_discount, :created_at, :updated_at
json.url admin_payment_url(payment, format: :json)
