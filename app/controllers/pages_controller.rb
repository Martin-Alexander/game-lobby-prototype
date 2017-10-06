class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_to_ongoing_game, only: [ :home, :lobby ]

  def home
    remove_user_from_lobby
    @all_lobby_games = Game.where(state: "lobby")
    @total_number_of_users_online = User.how_many_online 
  end

  def lobby  
    @game = Game.find_by_id(params[:id]) 
    if current_user.lobby != @game
      remove_user_from_lobby 
      current_user.join_lobby(@game)
    end
    @players_in_lobby = Player.where(game: @game).order(host: :desc)
  end

  private 

  def remove_user_from_lobby
    current_user.leave_lobby if current_user.is_in_lobby?
  end

  def redirect_to_ongoing_game
    redirect_to game_path(current_user.active_game_in) if current_user.is_active_player_in_game?
  end
end
