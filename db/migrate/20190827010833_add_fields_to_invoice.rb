class AddFieldsToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :identifier, :string    
    add_column :invoices, :create_paied, :boolean   
    add_column :invoices, :person_paied, :integer
    add_column :invoices, :cancel_date, :datetime
    add_column :invoices, :person_cancel, :integer
    add_column :invoices, :charge_back_date, :datetime
    add_column :invoices, :person_charge_back, :integer
    add_reference :invoices, :company, foreign_key: true    
  end
end
