class CreateDegreeEducations < ActiveRecord::Migration
  def change
    create_table :degree_educations do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
