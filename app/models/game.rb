class Game < ApplicationRecord
  has_many :users

  validates :state, inclusion: { in: ["lobby", "game_on", "game_over", "paused"] }
end
