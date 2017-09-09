puts "Wiping database..."
User.destroy_all
Game.destroy_all
Player.destroy_all
puts "Database clean."

puts "Seeding users..."

  martin = User.create! username: "martin", password: "123456"
  sophie = User.create! username: "sophie", password: "123456"
  chloe = User.create! username: "chloe", password: "123456"

puts "Done seeding users."

puts "Seeding games & players..."

# Just created a new game
game_one = Game.create! data: "dummy data", active: false, started: false
Player.create! status: "player", host: true, game: game_one, user: martin

game_two = Game.create! data: "dummy data", active: false, started: false
Player.create! status: "player", host: true, game: game_two, user: chloe

# # Game fills up with one person
# game_three = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_three, user: martin
# Player.create! status: "player", host: false, game: game_three, user: chloe

# game_four = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_four, user: chloe
# Player.create! status: "player", host: false, game: game_four, user: sophie

# game_six = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_six, user: sophie
# Player.create! status: "player", host: false, game: game_six, user: martin

# # Game fills up with another person, three total
# game_five = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_five, user: martin
# Player.create! status: "player", host: false, game: game_five, user: chloe
# Player.create! status: "player", host: false, game: game_five, user: sophie

# game_seven = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_seven, user: sophie
# Player.create! status: "player", host: false, game: game_seven, user: martin
# Player.create! status: "player", host: false, game: game_seven, user: chloe

# # Game fills up with another person as an observer, three total
# game_eight = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_eight, user: martin
# Player.create! status: "player", host: false, game: game_eight, user: chloe
# Player.create! status: "observer", host: false, game: game_eight, user: sophie

# game_nine = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_nine, user: martin
# Player.create! status: "observer", host: false, game: game_nine, user: chloe
# Player.create! status: "player", host: false, game: game_nine, user: sophie

# game_ten = Game.create! data: "dummy data", active: false, started: false
# Player.create! status: "player", host: true, game: game_ten, user: sophie
# Player.create! status: "player", host: false, game: game_ten, user: chloe
# Player.create! status: "observer", host: false, game: game_ten, user: martin

# # Game is started
# game_eleven = Game.create! data: "dummy data", active: true, started: true
# Player.create! status: "player", host: true, game: game_eleven, user: martin
# Player.create! status: "player", host: false, game: game_eleven, user: chloe
# Player.create! status: "player", host: false, game: game_eleven, user: sophie

# game_twelve = Game.create! data: "dummy data", active: true, started: true
# Player.create! status: "player", host: true, game: game_twelve, user: martin
# Player.create! status: "observer", host: false, game: game_twelve, user: chloe
# Player.create! status: "player", host: false, game: game_twelve, user: sophie

# game_fourteen = Game.create! data: "dummy data", active: true, started: true
# Player.create! status: "player", host: true, game: game_fourteen, user: sophie
# Player.create! status: "player", host: false, game: game_fourteen, user: chloe
# Player.create! status: "observer", host: false, game: game_fourteen, user: martin

# # Game is paused
# game_fifteen = Game.create! data: "dummy data", active: false, started: true
# Player.create! status: "player", host: true, game: game_fifteen, user: martin
# Player.create! status: "player", host: false, game: game_fifteen, user: chloe
# Player.create! status: "player", host: false, game: game_fifteen, user: sophie

# game_sixteen = Game.create! data: "dummy data", active: false, started: true
# Player.create! status: "player", host: true, game: game_sixteen, user: martin
# Player.create! status: "observer", host: false, game: game_sixteen, user: chloe
# Player.create! status: "player", host: false, game: game_sixteen, user: sophie

# game_seventeen = Game.create! data: "dummy data", active: false, started: true
# Player.create! status: "player", host: true, game: game_seventeen, user: sophie
# Player.create! status: "player", host: false, game: game_seventeen, user: chloe
# Player.create! status: "observer", host: false, game: game_seventeen, user: martin

puts "Done seeding games & players."