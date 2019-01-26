class CreateTuitionPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :tuition_people do |t|
      t.references :person, foreign_key: true
      t.references :tuition, foreign_key: true
      t.datetime :due_date
      t.datetime :pay_day
      t.string :status_payment, limit: 50
      t.float :discount
      t.string :amount_paied    

      t.timestamps
    end
  end
end
