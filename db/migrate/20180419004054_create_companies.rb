class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :telephone
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
