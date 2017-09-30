class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players
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

  def is_in
    if Game.joins(:players).where("players.user_id = ? AND players.in_game = ?", self.id, true).any?
      "game"
    elsif Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").any?
      "lobby"
    else
      "menus"
    end
  end

  def lobby
    lobby_game = Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").first
    lobby_game ? lobby_game : false
  end

  def player_in_lobby
    player = Player.joins(:game).where("user_id = ? AND games.state = ?", self.id, "lobby").first
  end

  def change_role(new_role)
    self.player_in_lobby.update! role: new_role if self.lobby
    broadcast(self.lobby, { newRole: new_role })
  end

  def join_lobby(game)
    check_if_lobby(game)
    if !game.user_in_game?(self)
      Player.create! user: self, game: game, host: false, role: "player", in_game: false
      broadcast(game, { incrementPlayerCount: 1 })
    else
      raise StandardError, "User is already in lobby"
    end
  end

  def leave_lobby
    if self.is_in == "lobby"
      game = self.lobby
      player = Player.where(user: self, game: game).first
      if game.players.count == 1
        game.destroy!
      elsif player.host
        Player.where(game: game).order(:created_at).first.update! host: true
      end
      broadcast(game, { incrementPlayerCount: -1 })
      player.destroy!
    else
      raise StandardError, "User is not in lobby"
    end
  end

  def create_new_lobby
    if self.is_in == "menus"
      new_game = Game.create! data: "", state: "lobby"
      Player.create! user: self, game: new_game, role: "player", host: true, in_game: false
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
