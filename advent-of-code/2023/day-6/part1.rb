class Race
  attr_accessor :time, :record

  def initialize(time, record)
    @time = time.to_i
    @record = record.to_i
  end

  def race_options
    (0..@time).map do |i|
      speed = i
      distance = speed * (@time - i)
      { speed: speed, distance: distance }
    end
  end

  def ways_to_beat
    race_options.select{ |r| r[:distance] > @record}
  end
end

races = []
puzzle_input = File.readlines('puzzle-input.txt')

(1..4).each do |i|
  races << Race.new(puzzle_input[0].split(' ')[i], puzzle_input[1].split(' ')[i])
end

puts "solution: #{ races.map{ |r| r.ways_to_beat.count }.reduce(:*) }"