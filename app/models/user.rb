class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players
  has_many :games, through: :players

  validates :username, uniqueness: true, length: { minimum: 2 }

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
    Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").first
  end

  def join_lobby(game)
    check_if_lobby(game)
    if !game.user_in_game?(self)
      Player.create! user: self, game: game, host: false, role: "player", in_game: false
    else
      raise StandardError, "User is already in lobby"
    end
  end

  def leave_lobby
    if self.is_in == "lobby"
      game = self.lobby
      Player.where(user: self, game: game).first.destroy!
      game.destroy! if game.players.count.zero?
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

  def check_if_lobby(object)
    unless object.is_a?(Game) && object.state == "lobby"
      raise ArgumentError, "Invalid game: #{object}"
    end    
  end
end
