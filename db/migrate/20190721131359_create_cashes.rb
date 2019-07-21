class CreateCashes < ActiveRecord::Migration[5.0]
  def change
    create_table :cashes do |t|
      t.string :type
      t.string :person
      t.float :amount

      t.timestamps
    end
  end
end
