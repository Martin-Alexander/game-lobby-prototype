Player.destroy_all
Game.destroy_all
User.destroy_all

$default_password = "123456"

def create_user(username, online) 
  User.create username: username, password: $default_password, online: online
end

martin = create_user("martin", false)
sophie = create_user("sophie", false)
chloe = create_user("chloe", false)
adele = create_user("adele", false)
brittany = create_user("brittany", false)

# chloe_game = Game.create! data: "", state: "lobby"
# adele_game = Game.create! data: "", state: "lobby"
# brittany_game = Game.create! data: "", state: "lobby"

# Player.create! user: chloe, game: chloe_game, host: true, role: "player", in_game: false
# Player.create! user: adele, game: adele_game, host: true, role: "player", in_game: false
# Player.create! user: brittany, game: brittany_game, host: true, role: "player", in_game: false

# Join/Create Lobby Test Seed

# lobby_game = Game.create data: "", state: "lobby"
# active_game = Game.create data: "", state: "game_on"
# paused_game = Game.create data: "", state: "paused"
# finished_game = Game.create data: "", state: "game_over"

# # The lobby game
# Player.create user: martin, game: lobby_game, role: "player", host: true, in_game: false
# Player.create user: sophie, game: lobby_game, role: "player", host: false, in_game: false

# # The active game
# Player.create user: adele, game: active_game, role: "player", host: true, in_game: true
# Player.create user: brittany, game: active_game, role: "player", host: false, in_game: true

# # The paused game
# Player.create user: sophie, game: paused_game, role: "player", host: true, in_game: false
# Player.create user: chloe, game: paused_game, role: "player", host: false, in_game: false
# Player.create user: adele, game: paused_game, role: "player", host: false, in_game: false
# Player.create user: brittany, game: paused_game, role: "player", host: false, in_game: false

# # The finished game
# Player.create user: martin, game: finished_game, role: "player", host: true, in_game: false
# Player.create user: sophie, game: finished_game, role: "player", host: false, in_game: false
# Player.create user: chloe, game: finished_game, role: "player", host: false, in_game: false
# Player.create user: adele, game: finished_game, role: "player", host: false, in_game: false
# Player.create user: brittany, game: finished_game, role: "player", host: false, in_game: false