# create variable for total
total = 0

number_words = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six", 
    "seven",
    "eight",
    "nine"
]

File.readlines('puzzle-input.txt').each do |line|
    number_values = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten

    number_values.each_with_index do |number_val, index|
      if number_val.to_i.to_s == number_val
        number_values[index] = number_val.to_i
      else
        number_values[index] = number_words.find_index number_val
      end
    end

    total += "#{number_values.first}#{number_values.last}".to_i
end

puts "Total: #{total}"


