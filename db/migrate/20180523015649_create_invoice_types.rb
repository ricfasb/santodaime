class CreateInvoiceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
