class AddLeaderStatusToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :leader_status, :boolean
  end
end
