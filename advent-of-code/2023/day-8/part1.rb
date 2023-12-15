puzzle_input = File.readlines('puzzle-input.txt')

steps = puzzle_input[0].strip.split('')
step_index = 0
total_steps = 0
current_step = "AAA"
nodes = {}

puzzle_input[2..puzzle_input.length].each do |line|
  node_keys = line.scan(/(\w+)/).flatten
  nodes[node_keys[0]] = { L: node_keys[1], R: node_keys[2]}
end

while current_step != "ZZZ"
  # puts "step: #{current_step}, step #: #{step_index}, direction: #{steps[step_index]}, next node: #{nodes[current_step][steps[step_index].to_sym]}"
  current_step = nodes[current_step][steps[step_index].to_sym]
  step_index = step_index == steps.length - 1 ? 0 : step_index + 1
  total_steps += 1
end

puts "total steps: #{total_steps}"