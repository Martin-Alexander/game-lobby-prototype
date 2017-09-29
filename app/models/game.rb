class Game < ApplicationRecord
  has_many :players
  has_many :users, through: :players

  validates :state, inclusion: { in: ["lobby", "game_on", "game_over", "paused"] }
end
