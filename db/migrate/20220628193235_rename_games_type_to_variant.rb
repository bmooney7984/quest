class RenameGamesTypeToVariant < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :type, :variant
  end
end
