require './game'

games = []

File.readlines('puzzle-input.txt').each do |line|
  games << Game.new(line)
end

puts "Total multiplier: #{games.map(&:multipler).inject(:+)}"