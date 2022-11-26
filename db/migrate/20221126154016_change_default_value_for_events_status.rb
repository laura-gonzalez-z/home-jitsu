class ChangeDefaultValueForEventsStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :events, :status, nil
  end
end
