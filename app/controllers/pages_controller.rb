class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :remove_user_from_lobby

  def home
    @all_lobby_games = Game.where(state: "lobby")
  end

  def game_lobby
    @game = Game.find(params[:id])
    @players_in_lobby = Player.where(game: @game).order(host: :desc)
    current_user.join_lobby(@game)
  end

  private 

  def remove_user_from_lobby
    current_user.leave_lobby if current_user.is_in == "lobby"
  end
end
