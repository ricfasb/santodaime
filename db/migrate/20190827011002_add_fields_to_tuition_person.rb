class AddFieldsToTuitionPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :tuition_people, :person_paied, :integer
    add_column :tuition_people, :cancel_date, :datetime
    add_column :tuition_people, :person_cancel, :integer
    add_column :tuition_people, :charge_back_date, :datetime
    add_column :tuition_people, :person_charge_back, :integer
  end
end
