class AddFieldsToTuition < ActiveRecord::Migration[5.0]
  def change
    add_column :tuitions, :subject, :string
    add_column :tuitions, :message, :string
  end
end
