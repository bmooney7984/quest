class Quest < ApplicationRecord
  has_many :quest_assignments
  has_many :players, through: "quest_assignments"
  belongs_to :leader, class_name: "Player", foreign_key: "leader_id"
  accepts_nested_attributes_for :quest_assignments, reject_if: lambda {|attributes| attributes["player_id"] == "0"}

  validate :correct_number_of_participants
  validates :token_holder_id, presence: true
  validate :token_holder_in_participants

  after_create_commit do
    broadcast_replace_to "main-stream", partial: "quests/edit_frame", locals: {quest: self}, target: "lower-stream"
  end

  def correct_number_of_participants
    tableau = [2, 3, 2, 4, 3]
    game = Game.first
    if number_of_participants != tableau[game.next_quest_number - 1]
      errors.add(:number_of_participants, "is incorrect")
    end
  end

  def token_holder_in_participants
    unless quest_assignments.map {|el| el.player_id}.include?(token_holder_id)
      errors.add(:token_holder_id, "is incorrect")
    end
  end

end
