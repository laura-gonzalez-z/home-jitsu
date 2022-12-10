class ChangeGuestsStatusDefaultFrompendingToPending < ActiveRecord::Migration[7.0]
  def change
    change_column_default :guests, :status, from: "pending", to: "Pending"
  end
end
