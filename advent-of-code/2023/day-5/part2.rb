
seeds = []

mappings = {
  seed_to_soil: [],
  soil_to_fertilizer: [],
  fertilizer_to_water: [],
  water_to_light: [],
  light_to_temperature: [],
  temperature_to_humidity: [],
  humidity_to_location: []
}
current_section = ""

File.readlines('puzzle-input.txt', chomp: true).each do |line|
  line_string = line.scan(/(\D+):/).flatten.first || ''
  line_split = line.split(" ")

  if line_string == 'seeds'
    seeds_list = line.scan(/:\s(.*)/).flatten.first.split(' ')
    (0..seeds_list.length-1).step(2).each do |step|
      seeds << { 
        start: seeds_list[step].to_i, 
        end: seeds_list[step].to_i + seeds_list[step + 1].to_i - 1
      }
    end
  elsif line_string.include?('map')
    current_section = line_string.gsub(' map', '').gsub('-', '_')
  elsif line.split(" ").length > 1
    mappings[current_section.to_sym] << {
      start: line_split[1].to_i,
      end: line_split[1].to_i + line_split[2].to_i - 1,
      offset: line_split[0].to_i - line_split[1].to_i
    }
  end
end

def map_category(map, seed)
  new_seeds = []
  map.each do |vals|
    if seed[:end] < vals[:start] || seed[:start] > vals[:end]     
      next
    end
    if seed[:start] >= vals[:start] && seed[:end] <= vals[:end] 
      new_seeds << { start: seed[:start] + vals[:offset], end: seed[:end] + vals[:offset] }
      break
    end
    if seed[:start] < vals[:start] && seed[:end] > vals[:end]   
      new_seeds << map_category(map, { start: seed[:start], end: vals[:start] - 1 })
      new_seeds << { start: vals[:start] + vals[:offset], end: vals[:end] + vals[:offset]}
      new_seeds << map_category(map, { start: vals[:end] +1, end: seed[:end] })
      break
    end
    if seed[:start] <= vals[:start] && seed[:end] <= vals[:end]    
      new_seeds << { start: vals[:start] + vals[:offset], end: seed[:end] + vals[:offset] }
      new_seeds << map_category(map, { start: seed[:start], end: vals[:start] - 1 }) if seed[:start] < vals[:start]
      break
    end
    if seed[:start] >= vals[:start] && seed[:end] >= vals[:end]  
      new_seeds << { start: seed[:start] + vals[:offset], end: vals[:end] + vals[:offset] }
      new_seeds << map_category(map, { start: vals[:end] +1, end: seed[:end] }) if seed[:end] > vals[:end] 
      break
    end
  end
  new_seeds = [seed] unless new_seeds.size > 0
  new_seeds.flatten
end

def find_lowest_location_number(seeds, mappings)
  mappings.keys.each do |category|
    puts "category: #{category}"
    next_seeds = []
    seeds.each do |seed|
      puts "seed: #{seed}"
      new_seeds = map_category(mappings[category], seed)
      next_seeds << new_seeds
    end
    seeds = next_seeds.flatten
  end
  seeds.map { |seed| seed[:start] }.min
end

lowest_location = find_lowest_location_number(seeds, mappings)
puts "The Lowest location number is: #{lowest_location}"