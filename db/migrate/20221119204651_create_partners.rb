class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      t.references :requester
      t.references :requestee
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
