class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :company, foreign_key: true
      t.string :name, unique: true
      t.string :description
      t.integer :quantity
      t.float :amount

      t.timestamps
    end
  end
end
