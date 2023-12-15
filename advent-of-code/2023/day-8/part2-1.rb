# PART 1
input = File.readlines('puzzle-input.txt').map(&:chomp)
instructions = input.shift.split.to_s.tr('[]', '').tr('"', '')

input.shift
total = 0
step_arr = []

Steps = Struct.new(:value, :left, :right)
input.each do |line|
    matches = line.match(/(\w+) = \((\w+), (\w+)\)/)
    step = Steps.new(matches[1], matches[2], matches[3])
    step_arr << step
end

step_arr.each do |step|
    if step.value == "AAA"
        while step.value != "ZZZ"
            instructions.each_char do |char|
                case char
                when "L" then next_step = step.left 
                when "R" then next_step = step.right
                end
                step = step_arr.find { |s| s.value == next_step }
                total += 1
                if step.value == "ZZZ"
                    break
                end
            end
        end
    end
end
puts total

# PART 2
total2 = 0
starters = []

step_arr.each do |step|
    if step.value[2] == "A"
        starters << step
    end
end

totals = []

starters.each do |step|
    total_temp = 0
    while step.value[2] != "Z"
        instructions.each_char do |char|
            case char
            when "L" then next_step = step.left 
            when "R" then next_step = step.right
            end
            step = step_arr.find { |s| s.value == next_step }
            total_temp += 1
            if step.value[2] == "Z"
                totals << total_temp
                break
            end
        end
    end
end
puts "---"
puts totals
puts totals.reduce(:lcm)