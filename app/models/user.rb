class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players, dependent: :destroy

  validates :username, uniqueness: true, length: { minimum: 2 }
  validates :is_at, inclusion: { in: ["main_menu", "my_games", "main_lobby", "game_lobby", "in_game"]}

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
    game_lobby = self.game_lobby_in
    player_was_host = Player.where(game: game_lobby, user: self).first.host
    Player.where(game: game_lobby, user: self).first.destroy
    self.update(is_at: "main_lobby")

    if game_lobby.players.count == 0
      game_lobby.destroy
    elsif player_was_host 
      game_lobby.players.first.update(host: true)
    end
  end

  def create_game
    new_game = Game.create!(data: "dummy", active: false, started: false)
    Player.create!(user: self, game: new_game, host: true, status: "player")
    self.update(is_at: "game_lobby")
  end
end
