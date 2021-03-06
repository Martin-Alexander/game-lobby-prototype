class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :users, through: :players

  validates :state, inclusion: { in: ["lobby", "game_on", "game_over", "paused"] }

  def user_in_game?(player_object)
    check_if_user(player_object)
    self.players.where(user_id: player_object.id).any?
  end

  def host
    self.players.where(host: true).first.user
  end

  def start
    self.update! state: "game_on"
  end

  def active_players
    Player.where("game_id = ? AND role = ?", self.id, "player")
  end

  def dead_players
    Player.where("game_id = ? AND role = ?", self.id, "dead_player")
  end

  def observers
    Player.where("game_id = ? AND role = ?", self.id, "observer")
  end

  private

  def check_if_user(object)
    unless object.is_a?(User)
      raise ArgumentError, "Invalid user: #{object}"
    end  
  end
end
