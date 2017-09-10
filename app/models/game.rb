class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :users, through: :players

  validates :data, presence: true

  def host
    players.where(host: true).first
  end
end
