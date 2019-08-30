class CreateLeans < ActiveRecord::Migration[5.0]
  def change
    create_table :leans do |t|
      t.references :company, foreign_key: true
      t.references :person,  foreign_key: true
      t.references :product, foreign_key: true
      t.date :expected_return
      t.integer :quantity
      t.datetime :returned

      t.timestamps
    end
  end
end
