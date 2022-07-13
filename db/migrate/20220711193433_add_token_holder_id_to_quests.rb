class AddTokenHolderIdToQuests < ActiveRecord::Migration[7.0]
  def change
    add_reference :quests, :token_holder, foreign_key: {to_table: :players}
  end
end
