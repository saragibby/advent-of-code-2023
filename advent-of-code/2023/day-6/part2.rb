class Race
  attr_accessor :time, :record, :min_speed, :max_speed

  def initialize(time, record)
    @time = time.to_i
    @record = record.to_i
    set_speeds
  end
  
  def set_speeds
    (0..@time).map do |i|
      distance = i * (@time - i)
      if distance > @record
        @min_speed = i
        break
      end
    end

    @time.downto(0  ).map do |i|
      distance = i * (@time - i)
      if distance > @record
        @max_speed = i
        break
      end
    end
  end
end

puzzle_input = File.readlines('puzzle-input.txt')

time = puzzle_input[0].scan(/(\d+)/).flatten.join('')
record = puzzle_input[1].scan(/(\d+)/).flatten.join('')

race = Race.new(time, record)

puts "Time:#{race.time} Record:#{race.record}"
puts "# of ways to win: #{(race.min_speed..race.max_speed).to_a.count}"