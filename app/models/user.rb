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
    # As far as I can tell, the main issue is that the following line of code is
    # not being called on the second refresh. When I use byebug to run it myself 
    # it seems to always work, otherwise it is simply not run even though other
    # parts of this function are being run
    self.update(is_at: "main_lobby")
    game_lobby = self.game_lobby_in
    player = Player.where(game: game_lobby, user: self).first
    if player 
      player_was_host = player.host
      Player.where(game: game_lobby, user: self).first.destroy
    end

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
