rows = []
valid_part_numbers = []

File.readlines('puzzle-input.txt').each do |line, index|
  rows << line
end

rows.each_with_index do |row, index|
  starting_index = 0
  
  row.scan(/(\d+)/).flatten.each do |part_number|
    index_in_row = row.index(part_number, starting_index)
    starting_index = index_in_row + part_number.length
    
    # puts "index_in_row: #{index_in_row}, part number length: #{part_number.length}, row length: #{row.length}, index: #{index}"
    part_num_length = index_in_row + part_number.length > row.length ? part_number.length - 1 : part_number.length

    row_chars = index_in_row == 0 ? row[index_in_row..index_in_row + part_num_length] : row[index_in_row-1..index_in_row + part_num_length]
    valid_in_row = row_chars.scan(/[^.\d\n]/).length > 0

    if index == 0
      valid_in_row_before = false
    else
      row_before_chars = index_in_row == 0 ? rows[index-1][index_in_row..index_in_row + part_num_length] : rows[index-1][index_in_row-1..index_in_row + part_num_length]
      valid_in_row_before = row_before_chars.scan(/[^.\d\n]/).length > 0
    end

    if index == rows.length - 1
      valid_in_row_after = false
    else
      row_after_chars = index_in_row == 0 ? rows[index+1][index_in_row..index_in_row + part_num_length] : rows[index+1][index_in_row-1..index_in_row + part_num_length]
      valid_in_row_after = row_after_chars.scan(/[^.\d\n]/).length > 0
    end
    
    # puts "number: #{part_number}, valid_in_row: #{valid_in_row} '#{row_chars}', valid_in_row_before: #{valid_in_row_before} '#{row_before_chars}', valid_in_row_after: #{valid_in_row_after} '#{row_after_chars}'"
    valid_part_numbers << part_number if valid_in_row || valid_in_row_before || valid_in_row_after
  end
end

puts "VALID PARTS: #{valid_part_numbers.count}"
puts "SUM: #{valid_part_numbers.map(&:to_i).sum}"