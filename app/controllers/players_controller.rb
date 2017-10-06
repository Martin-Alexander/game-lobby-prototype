class PlayersController < ApplicationController
  def update
    current_user.change_role(params[:new_role])
  end
end