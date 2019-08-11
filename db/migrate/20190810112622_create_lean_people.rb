class CreateLeanPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :lean_people do |t|
      t.references :lean, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
