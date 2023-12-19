puzzle_input = File.readlines('puzzle-input.txt')

lines = []

puzzle_input.each do |line|
  lines << { input: line.strip.split(' ').map(&:to_i), results: [] }
end

lines.each do |line|
  current_array = line[:input]
  line[:results] << current_array

  loop do
    line[:results] << current_array.each_cons(2).map{ |a, b| b - a }
    break if line[:results].last.uniq == [0]

    current_array = line[:results].last
  end
end

puts "TOTAL: #{lines.map{ |line| line[:results].map{ |r| r.last }.sum }.sum}"

