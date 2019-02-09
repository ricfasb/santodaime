class CreateDriverLicenses < ActiveRecord::Migration
  def change
    create_table :driver_licenses do |t|      
      t.string :number_cnh
      t.string :category_cnh
      t.date :date_issue
      t.date :expering_date
      t.integer :licensable_id
      t.string :licensable_type

      t.timestamps null: false
    end

    add_index :driver_licenses, :licensable_type
    add_index :driver_licenses, :licensable_id

  end
end
