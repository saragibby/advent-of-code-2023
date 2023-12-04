class Card
  attr_accessor :id, :winning_numbers, :my_numbers, :number_of_copies

  def initialize(line)
    @number_of_copies = 0
    @id = line.scan(/(\d*):/).flatten.first 
    @winning_numbers = line.scan(/:(.*)\|/).flatten.first.split(' ').map(&:to_i)
    @my_numbers = line.scan(/\|(.*)/).flatten.first.split(' ').map(&:to_i)
  end

  def matching_numbers
    @winning_numbers.intersection(@my_numbers)
  end

  def card_ids_to_copy
    (1..matching_numbers.length).map { |i| (@id.to_i + i).to_s }
  end
end

cards = []
copied_cards = []

File.readlines('puzzle-input.txt').each do |line, index|
  cards << Card.new(line)
end

cards.each do |card|
  if card.matching_numbers.length > 0
    puts "Card #{card.id} has #{card.matching_numbers.length} matches (#{card.card_ids_to_copy}), #{card.number_of_copies} copies"
    card.card_ids_to_copy.each do |card_id_to_copy|
      cards.select{ |c| c.id == card_id_to_copy }.first.number_of_copies += (card.number_of_copies + 1)
    end
  end
end

puts "Total cards: #{cards.count}, copied cards: #{cards.map(&:number_of_copies).sum}"
puts "GRAND TOTAL: #{cards.count + cards.map(&:number_of_copies).sum}  "