class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players, dependent: :destroy

  validates :username, uniqueness: true, length: { minimum: 2 }
  validates :is_at, inclusion: { in: ["main_menu", "my_games", "lobby", "staging", "in_game"]}

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def self.how_many_online
    User.where(online: true).length
  end

  def game_lobby_in
    Game.joins(:players).where(players: { user: self }, started: false).first
  end

  def remove_from_lobby
    Player.where(game: self.game_lobby_in, user: self).first.destroy
    self.is_at = "staging"
  end
end
