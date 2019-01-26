class CreateMaritalStates < ActiveRecord::Migration
  def change
    create_table :marital_states do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
