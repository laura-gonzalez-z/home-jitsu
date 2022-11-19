class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.references :event
      t.references :guest
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
