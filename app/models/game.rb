class Game < ApplicationRecord
  #add validation for number of players

  after_create_commit do
    broadcast_replace_to "join-link", partial: "games/join", locals: {game: self}, target: "join-link"
  end
end
