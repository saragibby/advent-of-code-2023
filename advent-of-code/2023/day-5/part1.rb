seeds = []
seed_to_soil = []
soil_to_fertilizer = []
fertilizer_to_water = []
water_to_light = []
light_to_temperature = []
temperature_to_humidity = []
humidity_to_location = []

current_section = ""

File.readlines('puzzle-input.txt').each do |line|
  line_string = line.scan(/(\D+):/).flatten.first || ''

  if line_string == 'seeds'
    line.scan(/(\d+)/).flatten.each do |seed|
      seeds << seed
    end
  elsif line_string.include?('map')
    current_section = line_string.gsub(' map', '').gsub('-', '_')
  elsif line.split(" ").length > 1
    line_values = {
      destination_range_start: line.split(' ')[0].to_i,
      source_range_start: line.split(' ')[1].to_i,
      range_length: line.split(' ')[2].to_i,
    }
    eval("#{current_section} << line_values")
  end
end

def find_match_for(mapping, source_value)
  match = mapping.select do |row| 
    row[:source_range_start] <= source_value && source_value <= (row[:source_range_start] + row[:range_length])  
  end.first

  if match
    source_index = source_value - match[:source_range_start]
    return match[:destination_range_start] + source_index
  end
end

results = []

seeds.each do |seed|
  soil = find_match_for(seed_to_soil, seed.to_i) || seed.to_i
  fertilizer = find_match_for(soil_to_fertilizer, soil) || soil
  water = find_match_for(fertilizer_to_water, fertilizer) || fertilizer
  light = find_match_for(water_to_light, water) || water
  temperature = find_match_for(light_to_temperature, light) || light
  humidity = find_match_for(temperature_to_humidity, temperature) || temperature
  location = find_match_for(humidity_to_location, humidity) || humidity

  results << { seed: seed.to_i, soil: soil, fertilizer: fertilizer, water: water, light: light, temperature: temperature, humidity: humidity, location: location }
end

puts results

puts "lowest location: #{results.map { |result| result[:location] }.min}"