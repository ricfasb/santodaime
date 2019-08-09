class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :description
      t.string :screen, limit: 50
      t.integer :father
      
    end
  end
end
