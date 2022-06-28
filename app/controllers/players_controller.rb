class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      session[:player_id] = @player.id
      redirect_to new_game_path
    else
      #error notification about bad name
    end
  end

  private

  def player_params
    return params.require(:player).permit(:name, :team, :role)
  end
end
