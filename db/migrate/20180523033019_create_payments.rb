class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :person, foreign_key: true
      t.references :invoice, foreign_key: true
      t.datetime :pay_day
      t.float :pay_amount
      t.float :discount
      t.string :obs_discount

      t.timestamps
    end
  end
end
