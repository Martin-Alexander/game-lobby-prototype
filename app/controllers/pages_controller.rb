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
    current_user.update(is_at: "stagging")
    @is_at = "staging"
    render "update"
  end

  def leave_game
    
  end
end
