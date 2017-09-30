class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :remove_user_from_lobby, except: [ :game_lobby, :change_role ]

  def home
    @all_lobby_games = Game.where(state: "lobby")
  end

  def game_lobby
    @game = Game.find(params[:id])
    if current_user.lobby != @game
      remove_user_from_lobby 
      current_user.join_lobby(@game)
    end
    @players_in_lobby = Player.where(game: @game).order(host: :desc)
  end

  def change_role
    current_user.change_role(params[:new_role])
  end

  private 

  def remove_user_from_lobby
    current_user.leave_lobby if current_user.is_in == "lobby"
  end
end
