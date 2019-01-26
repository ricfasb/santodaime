class AddFieldsToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :insert_tuition, :boolean
    add_reference :categories, :tuition, foreign_key: true
  end
end
