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
end
