class CreateTuitions < ActiveRecord::Migration[5.0]
  def change
    create_table :tuitions do |t|
      t.string :description
      t.integer :day
      t.float :amount
      t.boolean :send_email
      t.integer :day_email      
      t.references :email, foreign_key: true

      t.timestamps
    end
  end
end
