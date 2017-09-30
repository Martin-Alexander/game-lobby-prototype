class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :remove_user_from_lobby, except: [ :game_lobby, :change_role ]

  def home
    @all_lobby_games = Game.where(state: "lobby")
    @total_number_of_users_online = User.how_many_online 
  end

  def game_lobby  
    @game = Game.find_by_id(params[:id]) 
    if @game 
      if current_user.lobby != @game
        remove_user_from_lobby 
        current_user.join_lobby(@game)
      end
      @players_in_lobby = Player.where(game: @game).order(host: :desc)
    else
      redirect_to root_path
    end
  end

  def change_role
    current_user.change_role(params[:new_role])
  end

  def create_game
    new_game = current_user.create_new_game_lobby
    redirect_to game_lobby_path(new_game)
  end

  private 

  def remove_user_from_lobby
    current_user.leave_lobby if current_user.is_in == "lobby"
  end
end
