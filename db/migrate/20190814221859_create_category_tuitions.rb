class CreateCategoryTuitions < ActiveRecord::Migration[5.0]
  def change
    create_table :category_tuitions do |t|            
      t.references :category, foreign_key: true
      t.references :tuition, foreign_key: true
      
      t.timestamps
    end

  end
end
