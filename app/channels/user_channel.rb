class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel"
    current_user.update(online: true) if current_user
    update_number_of_users_online

    puts "#{current_user.username} SUBSCRIBED."
  end

  def unsubscribed
    current_user.update(online: false) if current_user
    update_number_of_users_online

    puts "#{current_user.username} UNSUBSCRIBED. REMOVING FROM LOBBY"
    current_user.remove_from_lobby if current_user.is_at == "game_lobby"
  end

  def update_number_of_users_online
    ActionCable.server.broadcast "user_channel", {number_of_users_online: User.how_many_online}
  end
end