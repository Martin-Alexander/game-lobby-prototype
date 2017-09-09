puts "Wiping database..."
User.destroy_all
puts "Database clean."

usernames = ["martin", "chloe", "sophie"]

puts "Seeding users..."
usernames.each do |username|
  User.create(username: username, password: "123456")
end
puts "Done seeding users."