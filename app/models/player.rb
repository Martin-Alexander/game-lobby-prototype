class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :role, inclusion: { in: ["player", "dead_player", "observer"] }
end
