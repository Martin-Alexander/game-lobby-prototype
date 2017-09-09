class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel"
    puts "subscribed: #{current_user.username}" if current_user
  end

  def unsubscribed
    puts "unsubscribed: #{current_user.username}" if current_user
  end  
end