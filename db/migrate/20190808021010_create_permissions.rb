class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :description      
      t.integer :father
      
    end
  end
end
