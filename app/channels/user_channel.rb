class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel"
    current_user.update(online: true) if current_user
  end

  def unsubscribed
    current_user.update(online: false) if current_user
  end  
end