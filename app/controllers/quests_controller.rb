class QuestsController < ApplicationController
  def new
    tableau = [2, 3, 2, 4, 3]
    game = Game.first

    @quest = Quest.new(number_of_participants: tableau[game.next_quest_number - 1])
    @player = Player.find(session[:player_id])

    players = Player.all
    players.each do |player|
      @quest.quest_assignments.build(player_id: player.id)
    end
  end
end
