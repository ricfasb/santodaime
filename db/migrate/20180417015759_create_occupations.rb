class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :description
      t.string :experience_time
      t.references :address, index: true, foreign_key: true
      t.integer :occupatiable_id
      t.string :occupatiable_type
      
      t.timestamps null: false
    end

    add_index :occupations, :occupatiable_type
    add_index :occupations, :occupatiable_id
  end
end
