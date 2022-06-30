class CreateQuestAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :quest_assignments do |t|
      t.references :quest
      t.references :player

      t.timestamps
    end
  end
end
