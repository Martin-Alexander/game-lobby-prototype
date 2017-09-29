class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  has_many :players
  has_many :games, through: :pla

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
    if Game.joins(:players).where("players.user_id = ? AND in_game = ?", self.id, true).any?
      "game"
    elsif Game.joins(:players).where("players.user_id = ? AND state = ?", self.id, "lobby").any?
      "lobby"
    else
      "menus"
    end
  end
end
