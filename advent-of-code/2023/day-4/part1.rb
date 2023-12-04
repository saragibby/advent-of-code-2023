class Card
  attr_accessor :id, :winning_numbers, :my_numbers

  def initialize(line)
    @id = line.scan(/(\d*):/).flatten.first 
    @winning_numbers = line.scan(/:(.*)\|/).flatten.first.split(' ').map(&:to_i)
    @my_numbers = line.scan(/\|(.*)/).flatten.first.split(' ').map(&:to_i)
  end

  def matching_numbers
    @winning_numbers.intersection(@my_numbers)
  end

  def points
    possible_points = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
    possible_points[matching_numbers.length]
  end
end

cards = []

File.readlines('puzzle-input.txt').each do |line, index|
  cards << Card.new(line)
end

puts "Sum of all points: #{cards.map(&:points).sum}"