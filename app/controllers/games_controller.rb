class GamesController < ApplicationController
  def show
    @game = Game.find_by_id(params[:id]) 
    redirect_away_from_invalid_game(@game)    
  end

  def create
    new_game = current_user.create_new_game_lobby
    redirect_to lobby_path(new_game)    
  end

  def start
    game = Game.find_by_id(params[:game_id])
    if game && game.host == current_user
      game.start
      redirect_to game_path(game)
    end    
  end

  def resign
    current_user.resign if current_user.is_active_player_in_game?
    redirect_to root_path    
  end

  def move
    ActionCable.server.broadcast "game_channel_#{current_user.active_game_in.id}", {
      message: "hi"
    }    
  end

  def ask
    question = JSON.parse(params[:json])
    case question["question"]
    when "gamedata initialized"
      game = Game.find(question["details"]["gameId"])
      if game.data == ""
        response = false
      else
        response = true
      end
    end

    render json: { question: question["question"], response: response }
  end

  private

  def redirect_away_from_invalid_game(game)
    if current_user.is_in_lobby?
      redirect_to lobby_path(current_user.lobby)
    else
      redirect_to root_path if !game || !current_user.is_in_game?(game)
    end
  end
end
