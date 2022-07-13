class AddNumberOfPassesToQuests < ActiveRecord::Migration[7.0]
  def change
    add_column :quests, :number_of_passes, :integer
  end
end
