class Player < ApplicationRecord
  #add name validations

  after_create_commit do
    broadcast_append_to "player-list", partial: "players/listing", locals: {player: self}, target: "player-list"
  end

  def is_first?
    return self == Player.order(:created_at).limit(1).take
  end


end
