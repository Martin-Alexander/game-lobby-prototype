class Game < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :data, presence: true

  def host
    players.where(host: true).first
  end
end
