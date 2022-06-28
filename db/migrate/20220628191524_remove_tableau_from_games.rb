class RemoveTableauFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :first_quest_participants
    remove_column :games, :second_quest_participants
    remove_column :games, :third_quest_participants
    remove_column :games, :fourth_quest_participants
    remove_column :games, :fifth_quest_participants
  end
end
