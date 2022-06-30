class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.integer :quest_order
      t.integer :number_of_participants
      t.integer :number_of_failures

      t.timestamps
    end
  end
end
