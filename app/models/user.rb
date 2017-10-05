class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players, dependent: :destroy
  has_many :games, through: :players

  validates :username, uniqueness: true, length: { minimum: 2 }

  def self.how_many_online
    User.where(online: true).count
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def active_game_in
    game = Game.joins(:players).where("players.user_id = ? AND players.role = ? AND state = ?", self.id, "player", "game").first
    raise StandardError, "User is not in active game" if game.nil?
    game
  end

  def is_active_player_in_game?
    Game.joins(:players).where("players.user_id = ? AND players.role = ? AND state = ?", self.id, "player", "game_on").any?
  end

  def is_in_lobby?
    Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").any?
  end

  def lobby
    lobby_game = Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").first
    lobby_game ? lobby_game : false
  end

  def player_in_lobby
    player = Player.joins(:game).where("user_id = ? AND games.state = ?", self.id, "lobby").first
  end

  def create_new_game_lobby
    new_game = Game.create! data: "", state: "lobby"
    Player.create! user: self, game: new_game, role: "player", host: true
    broadcast(new_game, { newGame: { hostName: self.username } })
    return new_game
  end

  def change_role(new_role)
    self.player_in_lobby.update! role: new_role if self.lobby
    broadcast(self.lobby, { newRole: new_role })
  end

  def join_lobby(game)
    check_if_lobby(game)
    if !game.user_in_game?(self)
      Player.create! user: self, game: game, host: false, role: "player"
      broadcast(game, { incrementPlayerCount: 1, username: self.username })
    else
      raise StandardError, "User is already in lobby"
    end
  end

  def leave_lobby
    if self.is_in_lobby?
      game = self.lobby
      player = Player.where(user: self, game: game).first
      if game.players.count == 1
        broadcast(game, "gameDestroy")
        game.destroy!
        player.destroy!
      elsif player.host
        player.destroy!
        new_host = Player.where(game: game).order(:created_at).first
        new_host.update! host: true
        broadcast(game, { incrementPlayerCount: -1, newHost: { username: new_host.username, id: new_host.user.id } })
      else
        player.destroy!
        broadcast(game, { incrementPlayerCount: -1 })
      end
    else
      raise StandardError, "User is not in lobby"
    end
  end

  def create_new_lobby
    if !self.is_in_lobby? && !self.is_active_player_in_game?
      new_game = Game.create! data: "", state: "lobby"
      Player.create! user: self, game: new_game, role: "player", host: true
      return new_game
    else
      raise StandardError, "User must be in 'menus' to create lobby"
    end
  end

  private

  def broadcast(game, change)
    ActionCable.server.broadcast "user_channel", { playerUpdate: 
      {
        gameId: game.id,
        userId: self.id,
        change: change
      }
    }
  end

  def check_if_lobby(object)
    unless object.is_a?(Game) && object.state == "lobby"
      raise ArgumentError, "Invalid game: #{object}"
    end    
  end
end
