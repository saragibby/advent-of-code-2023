puzzle_input = File.readlines('puzzle-input.txt')

steps = puzzle_input[0].strip.split('')
current_steps = []
nodes = {}
totals = []

puzzle_input[2..puzzle_input.length].each do |line|
  node_keys = line.scan(/(\w+)/).flatten
  nodes[node_keys[0]] = { L: node_keys[1], R: node_keys[2]}
end

current_steps = nodes.keys.select { |key| key[2] == "A" }

current_steps.each do |step|
  current_step = step
  step_index = 0
  total_steps = 0

  while current_step[2] != "Z"
    current_step = nodes[current_step][steps[step_index].to_sym]
    step_index = step_index == steps.length - 1 ? 0 : step_index + 1
    total_steps += 1
  end

  totals << total_steps
end

puts "first instance for each: #{totals}"
puts "least common multiplier of results: #{totals.reduce(:lcm)}"