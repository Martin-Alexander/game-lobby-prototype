class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel"
    current_user.update(online: true) if current_user
    update_number_of_users_online
  end

  def unsubscribed
    current_user.update(online: false) if current_user
    update_number_of_users_online
  end

  def update_number_of_users_online
    ActionCable.server.broadcast "user_channel", { "userUpdate" => {
      "numberOfUsersOnline" => User.how_many_online 
      } 
    }
  end
end