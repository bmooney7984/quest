class AddVeteranStatusToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :veteran_status, :boolean
  end
end
