class AddTrainingStyleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :training_style, :string
  end
end
