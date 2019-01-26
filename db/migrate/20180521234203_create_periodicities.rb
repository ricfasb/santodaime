class CreatePeriodicities < ActiveRecord::Migration[5.0]
  def change
    create_table :periodicities do |t|
      t.string :description
      t.string :days

      t.timestamps
    end
  end
end
