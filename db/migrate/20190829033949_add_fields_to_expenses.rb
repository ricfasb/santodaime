class AddFieldsToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :date_expense, :date
  end
end
