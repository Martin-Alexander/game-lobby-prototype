class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @all_lobby_games = Game.where(state: "lobby")
  end

  def game_lobby
    @game = Game.find(params[:id])
  end
end
