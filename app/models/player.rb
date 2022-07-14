class Player < ApplicationRecord
  has_many :quest_assignments
  has_many :quests, through: "quest_assignments"
  has_one :quest_led, class_name: "Quest", foreign_key: "leader_id"
  belongs_to :left_pointee, class_name: "Player", optional: true
  belongs_to :right_pointee, class_name: "Player", optional: true
  has_one :left_pointer, class_name: "Player", foreign_key: "left_pointee_id"
  has_one :right_pointer, class_name: "Player", foreign_key: "right_pointee_id"

  #add name validations

  validate :two_pointees_set, if: :pointee_set?

  after_create_commit do
    broadcast_append_to "player-list", partial: "players/listing", locals: {player: self}, target: "player-list"
  end

  def is_first?
    return self == Player.order(:created_at).limit(1).take
  end

  def pointee_set?
    if left_pointee_id || right_pointee_id
      return true
    else
      return false
    end
  end

  def two_pointees_set
    if left_pointee_id == nil || right_pointee_id == nil || left_pointee_id == right_pointee_id
      errors.add(:base, :two_distinct_accusations_not_made)
    end
  end

  def self.all_accusations_made?
    if where(left_pointee_id: nil).any? || where(right_pointee_id: nil).any?
      return false
    else
      return true
    end
  end

  def self.set_random_leader
    # nonrandom version for testing purposes
      # leader = all.first
      # leader.update(leader_status: true, veteran_status: true)
    # random version
      leader = all.sample
      leader.update(leader_status: true, veteran_status: true)
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
