class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :content
      t.references :user
      t.references :writer
      t.integer :rating

      t.timestamps
    end
  end
end
