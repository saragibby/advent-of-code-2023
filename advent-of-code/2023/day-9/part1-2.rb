# PART 2
histories = []
total2 = 0

File.open("puzzle-input.txt") do |file|
    file.each_line do |line|
        histories << line.split.map(&:to_i)
    end
end

histories.each do |history|
    descents = [history]
    while true
        next_level = descents.last.each_cons(2).map { |a, b| b - a }
        break if next_level.all? { |x| x == 0 }
        descents << next_level
    end
    diff = 0
    descents.reverse_each do |descent|
        diff = descent.first - diff
        # puts "#{descent.inspect}(#{diff})"
    end
    puts diff
    total2 += diff
end

puts total2