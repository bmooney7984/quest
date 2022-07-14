class AddPointingIdsToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :left_pointee, foreign_key: {to_table: :players}
    add_reference :players, :right_pointee, foreign_key: {to_table: :players}
  end
end
