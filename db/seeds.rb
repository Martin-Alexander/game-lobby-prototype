Player.destroy_all
Game.destroy_all
User.destroy_all

lobby_game = Game.create data: "", state: "lobby"
active_game = Game.create data: "", state: "game_on"
paused_game = Game.create data: "", state: "paused"
finished_game = Game.create data: "", state: "game_over"

$default_password = "123456"

def create_user(username, online) 
  User.create username: username, password: $default_password, online: online
end

martin = create_user("martin", true)
sophie = create_user("sophie", true)
chloe = create_user("chloe", false)
adele = create_user("adele", true)
brittany = create_user("brittany", true)

# The lobby game
Player.create user: martin, game: lobby_game, role: "player", host: true, in_game: false
Player.create user: sophie, game: lobby_game, role: "player", host: false, in_game: false

# The active game
Player.create user: adele, game: active_game, role: "player", host: true, in_game: true
Player.create user: brittany, game: active_game, role: "player", host: false, in_game: true

# The paused game
Player.create user: sophie, game: paused_game, role: "player", host: true, in_game: false
Player.create user: chloe, game: paused_game, role: "player", host: false, in_game: false
Player.create user: adele, game: paused_game, role: "player", host: false, in_game: false
Player.create user: brittany, game: paused_game, role: "player", host: false, in_game: false

# The finished game
Player.create user: martin, game: finished_game, role: "player", host: true, in_game: false
Player.create user: sophie, game: finished_game, role: "player", host: false, in_game: false
Player.create user: chloe, game: finished_game, role: "player", host: false, in_game: false
Player.create user: adele, game: finished_game, role: "player", host: false, in_game: false
Player.create user: brittany, game: finished_game, role: "player", host: false, in_game: false