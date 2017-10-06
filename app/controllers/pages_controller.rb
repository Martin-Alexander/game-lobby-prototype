class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_to_ongoing_game, only: [ :home, :game_lobby ]

  def home
    remove_user_from_lobby
    @all_lobby_games = Game.where(state: "lobby")
    @total_number_of_users_online = User.how_many_online 
  end

  def game_lobby  
    @game = Game.find_by_id(params[:id]) 
    if current_user.lobby != @game
      remove_user_from_lobby 
      current_user.join_lobby(@game)
    end
    @players_in_lobby = Player.where(game: @game).order(host: :desc)
  end

  def change_role
    current_user.change_role(params[:new_role])
  end

  def create_game
    new_game = current_user.create_new_game_lobby
    redirect_to game_lobby_path(new_game)
  end

  def game
    @game = Game.find_by_id(params[:id]) 
    redirect_away_from_invalid_game(@game)
  end

  def start_game
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

  def test_move
  end

  private 

  def remove_user_from_lobby
    current_user.leave_lobby if current_user.is_in_lobby?
  end

  def redirect_to_ongoing_game
    redirect_to game_path(current_user.active_game_in) if current_user.is_active_player_in_game?
  end

  def redirect_away_from_invalid_game(game)
    if current_user.is_in_lobby?
      redirect_to game_lobby_path(current_user.lobby)
    else
      redirect_to root_path if !game || !current_user.is_in_game?(game)
    end
  end
end
