class GameLobbyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_lobby_#{current_user.game_lobby_in}_channel"
  end

  def unsubscribed
  end
end