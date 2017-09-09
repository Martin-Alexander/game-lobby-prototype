class Game < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :data, presence: true
  validates :active, presence: true
  validates :started, presence: true
end
