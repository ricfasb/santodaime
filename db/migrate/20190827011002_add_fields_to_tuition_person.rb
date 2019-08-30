class AddFieldsToTuitionPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :tuition_people, :person_paied, :integer
    add_column :tuition_people, :cancel_date, :datetime
    add_column :tuition_people, :person_cancel, :integer
    add_column :tuition_people, :charge_back_date, :datetime
    add_column :tuition_people, :person_charge_back, :integer
    add_reference :tuition_people, :payment_type, foreign_key: true 
  end
end
