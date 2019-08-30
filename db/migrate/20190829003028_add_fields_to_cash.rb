class AddFieldsToCash < ActiveRecord::Migration[5.0]
  def change
    add_column :cashes, :pay_day,  :datetime
    add_column :cashes, :category, :string
    add_column :cashes, :due_date, :date    
  end
end
