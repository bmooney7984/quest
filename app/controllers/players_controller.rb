class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.leader_status = false
    @player.veteran_status = false

    if @player.save
      session[:player_id] = @player.id
      redirect_to new_game_path
    else
      #error notification about bad name
    end
  end

  def edit
    @players = Player.all
    @player = Player.find(session[:player_id])
    @leader = Player.where(leader_status: true).take
    @nonveterans = Player.where(veteran_status: false)
  end

  def update
    @old_leader = Player.where(leader_status: true).take
    @old_leader.update(leader_status: false)

    @new_leader = Player.find(params[:id])
    @new_leader.update(leader_status: true, veteran_status: true)

    @new_leader.broadcast_replace_to "main-stream", target: "lower-stream", partial: "quests/new_frame"
  end

  private

  def player_params
    return params.require(:player).permit(:name, :team, :role)
  end
end
