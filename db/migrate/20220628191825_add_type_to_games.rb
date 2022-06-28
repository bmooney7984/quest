class AddTypeToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :type, :string
  end
end
