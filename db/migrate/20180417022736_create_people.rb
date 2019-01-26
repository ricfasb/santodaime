class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.attachment :photo
      t.date :date_born
      t.date :date_enroll
      t.float :height
      t.string :rg
      t.string :cpf, limit: 11
      t.string :telephone_residence, limit: 11
      t.string :smartphone_number, limit: 11
      t.string :telephone_message, limit: 11
      t.string :message_person
      t.string :facebook
      t.string :father_name
      t.string :mother_name
      t.references :category, index: true, foreign_key: true
      
      t.references :address, index: true, foreign_key: true
      t.references :driver_license, index: true, foreign_key: true
      t.references :occupation, index: true, foreign_key: true
      t.references :deficiency_person, index: true, foreign_key: true

      t.references :marital_state, index: true, foreign_key: true
      t.references :degree_education, index: true, foreign_key: true

      t.string :wifes_name
      t.integer :among_sun      
      t.string :course      
      t.string :motive
      t.string :complementary_information
      t.string :fingerprint

      t.integer :on_line
      t.timestamps null: false
    end
    add_index :people, :cpf
  end
end
