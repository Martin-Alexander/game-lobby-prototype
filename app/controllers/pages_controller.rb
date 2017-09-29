class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @all_lobby_games = Game.where(state: "lobby")
  end
end
