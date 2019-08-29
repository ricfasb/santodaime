class AddFieldsToCash < ActiveRecord::Migration[5.0]
  def change
    add_column :cashes, :pay_day, :datetime
  end
end
