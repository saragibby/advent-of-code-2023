require './game'

MAX_CUBE_COUNT = {
  :red => 12,
  :green => 13,
  :blue => 14
}

games = []

File.readlines('puzzle-input.txt').each do |line|
  games << Game.new(line)
end

games_possible = games.select { |game| game.is_game_possible? }

puts "Game IDs: #{games_possible.map { |game| game.game_id }.join(", ") }"
puts "Game IDs sum: #{games_possible.map { |game| game.game_id }.inject(:+)}"
