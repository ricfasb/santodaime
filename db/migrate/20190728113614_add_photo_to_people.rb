class AddPhotoToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :photo_file, :binary
  end
end
