class GamesController < ApplicationController
  def new
    @players = Player.all
    @player = Player.find(session[:player_id])
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.quests_passed = 0
    if params[:number_of_players] == 4
      @game.quests_remaining = 4
    else
      @game.quests_remaining = 5
    end

    respond_to do |format|
      if @game.save
        format.turbo_stream
      else
      end
    end
  end

  def show

  end

  private

  def game_params
    return params.require(:game).permit(:number_of_players, :variant)
  end
end
