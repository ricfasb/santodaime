class CreateProfilePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_permissions do |t|      
      t.references :profile, foreign_key: true
      t.references :permission, foreign_key: true

    end
  end
end
