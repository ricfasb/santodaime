class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :person, foreign_key: true
      t.references :invoice_type, foreign_key: true
      t.string :description
      t.date :due_date
      t.float :amount
      t.datetime :pay_day
      t.float :discount
      t.string :amount_paied  

      t.timestamps
    end
  end
end
