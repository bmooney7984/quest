class AddLeaderIdToQuests < ActiveRecord::Migration[7.0]
  def change
    add_reference :quests, :leader, foreign_key: {to_table: :players}
  end
end
