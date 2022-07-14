class QuestsController < ApplicationController
  def new
    tableau = [2, 3, 2, 4, 3]
    game = Game.first

    @quest = Quest.new(number_of_participants: tableau[game.next_quest_number - 1])
    @player = Player.find(session[:player_id])
    @leader = Player.where(leader_status: true).take

    @players = Player.all
    @players.each do |player|
      @quest.quest_assignments.build(player_id: player.id)
    end
  end

  def create
    game = Game.first
    player = Player.find(session[:player_id])
    @quest = player.build_quest_led(quest_params)
    boxes_checked = quest_params["quest_assignments_attributes"].to_hash.reduce(0) do |acc, el|  #count number of boxes checked, to use validation at the model level
      if el.last["player_id"] == "0"
        acc
      else
        acc = acc + 1
      end
    end
    unless @quest.update(quest_order: game.next_quest_number, number_of_participants: boxes_checked, number_of_passes: 0, number_of_failures: 0)
      #they put in wrong number of participants?
    end
  end

  def edit
    @quest = Quest.find(params[:id])
    @player = Player.find(session[:player_id])
  end

  def update
    @quest = Quest.find(params[:id])
    game = Game.first

    if params[:quest][:choice] == "pass"
      @quest.update(number_of_passes: @quest.number_of_passes + 1)
    else
      @quest.update(number_of_failures: @quest.number_of_failures + 1)
    end

    if @quest.number_of_passes + @quest.number_of_failures == @quest.number_of_participants # every quest participant has voted
      game.update(quests_remaining: game.quests_remaining - 1, next_quest_number: game.next_quest_number + 1)
      if @quest.number_of_failures == 0 # quest passed
        game.update(quests_passed: game.quests_passed + 1)
      end
      @quest.broadcast_replace_to "main-stream", target: "upper-stream", partial: "quests/index", locals: {quests: Quest.order(:quest_order), players: Player.all}
      if game.quests_passed == 3
        @quest.broadcast_replace_to "main-stream", target: "lower-stream", partial: "games/end", locals: {winning_team: "good"}
        Game.delete_all
        Quest.delete_all
        Player.delete_all
        QuestAssignment.delete_all
      end
      if game.quests_passed + game.quests_remaining < 3
        # good's last chance
        Player.find(session[:player_id])
        @quest.broadcast_replace_to "main-stream", target: "lower-stream", partial: "players/edit_frame", locals: {}
      else
        @quest.broadcast_replace_to "main-stream", target: "lower-stream", partial: "players/multi_edit_frame"
      end
    else # not every quest participant has voted
      render "waiting"
    end
  end

  private

  def quest_params
    return params.require(:quest).permit(:token_holder_id, quest_assignments_attributes: [:player_id])
  end
end
