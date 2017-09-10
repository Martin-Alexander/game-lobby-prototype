class PagesController < ApplicationController
  def main
    if current_user
      @is_at = current_user.is_at
    else
      @is_at = "main_menu"
    end
  end

  def update
    if current_user
      current_user.update(is_at: params[:destination])
      @is_at = current_user.is_at
    else
      @is_at = "main_menu"
    end
  end

  def join_game
    game = Game.find(params[:game_id])
    Player.create(status: "player", host: false, game: game, user: current_user)
    current_user.update(is_at: "game_lobby")
    @is_at = "game_lobby"
    render "update"
  end

  def leave_game
    current_user.remove_from_lobby
    @is_at = "main_lobby"
    render "update"
  end

  def create_game
    current_user.create_game
    @is_at = "game_lobby"
    render "update"
  end
end
