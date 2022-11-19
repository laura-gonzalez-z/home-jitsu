class AddFirstNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :belt, :string
    add_column :users, :years_of_experience, :integer
    add_column :users, :address, :string
    add_column :users, :description, :string
    add_column :users, :gender, :string
    add_column :users, :photo, :string
  end
end
