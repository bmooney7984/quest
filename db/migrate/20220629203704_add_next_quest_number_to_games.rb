class AddNextQuestNumberToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :next_quest_number, :integer
  end
end
