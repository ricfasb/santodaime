class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :zip_code
      t.string :street
      t.string :number
      t.string :complement
      t.string :reference
      t.string :neighbourhood
      t.integer :addressable_id
      t.string :addressable_type
      t.references :city, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :addresses, :addressable_type
    add_index :addresses, :addressable_id
  end
end
