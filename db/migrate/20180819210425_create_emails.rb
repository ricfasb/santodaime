class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.references :company, foreign_key: true
      t.references :person,  foreign_key: true
      t.references :category,foreign_key: true
      t.string :title
      t.string :subject
      t.string :message
      t.string :email_type
      t.datetime :schedule

      t.timestamps
    end
  end
end
