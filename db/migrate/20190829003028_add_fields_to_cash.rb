class AddFieldsToCash < ActiveRecord::Migration[5.0]
  def change
    add_column :cashes, :pay_day,  :datetime
    add_column :cashes, :category, :string
    add_column :cashes, :due_date, :date   
    add_column :cashes, :cancel_date, :datetime 
    add_column :cashes, :person_cancel, :integer 
    add_column :cashes, :charge_back_date, :datetime
    add_column :cashes, :person_charge_back, :integer 
  end
end
