class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :status, default: "open"
      t.references :host
      t.string :description
      t.string :title
      t.string :photo

      t.timestamps
    end
  end
end
