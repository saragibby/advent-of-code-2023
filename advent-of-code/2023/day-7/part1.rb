HAND_ORDER = ['high_card', 'one_pair', 'two_pair', 'three', 'full_house', 'four', 'five']
CARD_ORDER = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J','Q', 'K', 'A']

class Hand
  attr_accessor :cards, :bid

  def initialize(cards, bid)
    @cards = cards.split("")
    @bid = bid
  end

  def type
    card_counts = Hash[@cards.group_by { |x| x }.map { |k, v| [k, v.length] }]
    
    case
    when card_counts.keys.count == 5
      HAND_ORDER[0]
    when card_counts.select{ |k, v| v == 5 }.count == 1
      HAND_ORDER[6]
    when card_counts.select{ |k, v| v == 4 }.count == 1
      HAND_ORDER[5]
    when card_counts.select{ |k, v| v == 3 }.count == 1 && card_counts.select{ |k, v| v == 2 }.count == 1
      HAND_ORDER[4]
    when card_counts.select{ |k, v| v == 3 }.count == 1
      HAND_ORDER[3]
    when card_counts.select{ |k, v| v == 2 }.count == 2
      HAND_ORDER[2]
    when card_counts.select{ |k, v| v == 2 }.count == 1
      HAND_ORDER[1]
    end
  end
end

class Game
  attr_accessor :hands
  
  def initialize(hands)
    @hands = hands.sort_by do |h|
      [ 
        HAND_ORDER.index(h.type), 
        CARD_ORDER.index(h.cards[0]), 
        CARD_ORDER.index(h.cards[1]), 
        CARD_ORDER.index(h.cards[2]), 
        CARD_ORDER.index(h.cards[3]), 
        CARD_ORDER.index(h.cards[4])
      ]
    end
  end

  def total_winnings
    @hands.each_with_index.reduce(0) do |memo, (hand, index)|
      memo + (hand.bid * (index + 1))
    end
  end
end

hands = []
puzzle_input = File.readlines('puzzle-input.txt')

puzzle_input.each do |line|
  hand, bid = line.split(' ')
  hands << Hand.new(hand, bid.to_i)
end

game = Game.new(hands)

puts "losing hand: #{game.hands.first.cards.join("")}"
puts "winning hand: #{game.hands.last.cards.join("")}"

puts "TOTAL WINNINGS: #{game.total_winnings}"