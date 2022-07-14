class Game < ApplicationRecord
  #add validation for number of players

  after_create_commit do
    broadcast_replace_to "join-link", partial: "games/join", locals: {game: self}, target: "join-link"
  end

  def evildoer_escapes?
    Player.where(team: "evil").any? do |evildoer|
      Player.where(team: "good").none? do |good_guy|
        good_guy.left_pointee == evildoer || good_guy.right_pointee == evildoer
      end
    end
  end

  def good_guy_accused?
    Player.where(team: "good").any? do |good_victim|
      Player.where(team: "good").any? do |good_accuser|
        good_accuser.left_pointee == good_victim || good_accuser.right_pointee == good_victim
      end
    end
  end

  def last_chance_winner
    if evildoer_escapes? || good_guy_accused?
      return "evil"
    else
      return "good"
    end
  end

end
