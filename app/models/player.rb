class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :status, inclusion: { in: ["player", "observer"] }

  def username
    self.user.username
  end

  def online
    self.user.online
  end

  def state
    self.user.state
  end
end
