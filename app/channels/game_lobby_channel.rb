class GameLobbyChannel < ApplicationCable::Channel
  def subscribed
    puts "#{current_user.username} SUBSCRIBED TO GAME LOBBY: #{params[:game_lobby_id]}"
    stream_from "game_lobby_#{params[:game_lobby_id]}_channel"
    ActionCable.server.broadcast "game_lobby_#{params[:game_lobby_id]}_channel", { id: params[:game_lobby_id] }
  end

  def unsubscribed
  end
end