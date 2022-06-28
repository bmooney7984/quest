class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :number_of_players
      t.integer :quests_passed
      t.integer :quests_remaining
      t.integer :first_quest_participants
      t.integer :second_quest_participants
      t.integer :third_quest_participants
      t.integer :fourth_quest_participants
      t.integer :fifth_quest_participants

      t.timestamps
    end
  end
end
