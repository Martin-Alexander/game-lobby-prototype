class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :status, inclusion: { in: ["player", "observer"] }
end
