class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.references :company, foreign_key: true
      t.string :description
      t.string :observation
      t.string :provider
      t.float :amount

      t.timestamps
    end
  end
end
