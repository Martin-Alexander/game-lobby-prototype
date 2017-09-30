class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :users, through: :players

  validates :state, inclusion: { in: ["lobby", "game_on", "game_over", "paused"] }

  def self.create_new_game_lobby(user)
    new_game = Game.create! data: "", state: "lobby"
    Player.create! user: user, game: new_game, role: "player", host: true
  end

  def user_in_game?(player_object)
    check_if_user(player_object)
    self.players.where(user_id: player_object.id).any?
  end

  def host
    self.players.where(host: true).first.user
  end

  private

  def check_if_user(object)
    unless object.is_a?(User)
      raise ArgumentError, "Invalid user: #{object}"
    end  
  end
end
