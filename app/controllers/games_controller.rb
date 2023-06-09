class GamesController < ApplicationController
  def new
    @players = Player.all
    @player = Player.find(session[:player_id])
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    unless @game.save
      #can something go wrong here?
    end
    @game.update(number_of_players: 5)
    @game.update(next_quest_number: 1)
    @game.update(quests_passed: 0)
    if params[:number_of_players] == 4
      @game.update(quests_remaining: 4)
    else
      @game.update(quests_remaining: 5)
    end

    Player.set_roles
    Player.set_random_leader
  end

  def show
    @player = Player.find(session[:player_id])
    @scion = Player.where(role: "scion").take
    @quests = Quest.order(:quest_order)
    @players = Player.all
  end

  def destroy
    Game.delete_all
    Quest.delete_all
    Player.delete_all
    QuestAssignment.delete_all
  end

  private

  def game_params
    return params.require(:game).permit(:variant)
  end
end
