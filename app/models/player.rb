class Player < ApplicationRecord
  has_many :quest_assignments

  #add name validations

  after_create_commit do
    broadcast_append_to "player-list", partial: "players/listing", locals: {player: self}, target: "player-list"
  end

  def is_first?
    return self == Player.order(:created_at).limit(1).take
  end

  def self.set_random_leader
    # nonrandom version for testing purposes
    leader = all.first
    leader.update(leader_status: true, veteran_status: true)
    # random version
    # leader = all.sample
    # leader.update(leader_status: true, veteran_status: true)
  end

  def self.set_roles
    players = self.all.to_a
    3.times do
      player = players.sample
      player.update(team: "good", role: "knight")
      players.delete_if {|el| el == player}
    end
    player = players.sample
    player.update(team: "evil", role: "scion")
    players.delete_if {|el| el == player}
    player = players.sample
    player.update(team: "evil", role: "morgan")
  end

end
