# create variable for total
total = 0

File.readlines('puzzle-input.txt').each do |line|
    # parse lne for only digits
    digits = line.scan(/\d/)
    code = "#{digits[0]}#{digits[digits.length - 1]}"
    total += "#{digits[0]}#{digits[digits.length - 1]}".to_i
end

puts "TOTAL: #{total}"