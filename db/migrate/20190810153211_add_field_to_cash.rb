class AddFieldToCash < ActiveRecord::Migration[5.0]
  def change
    add_column :cashes, :identifier, :integer
  end
end
