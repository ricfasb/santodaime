class CreateDeficiencyPeople < ActiveRecord::Migration
  def change
    create_table :deficiency_people do |t|
      t.string :chronic_disease
      t.string :controlled_medication
      t.integer :deficiencable_id
      t.string :deficiencable_type
      
      t.timestamps null: false
    end

    add_index :deficiency_people, :deficiencable_type
    add_index :deficiency_people, :deficiencable_id
  end
end
