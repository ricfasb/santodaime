class AddGenderToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :gender, :string, limit: 1
  end
end
