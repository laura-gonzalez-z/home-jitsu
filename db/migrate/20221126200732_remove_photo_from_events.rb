class RemovePhotoFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :photo, :string
  end
end
