rows = []

def row_parts(row)
  parts = []
  starting_part_index = 0

  row.scan(/(\d+)/).flatten.each do |part_number|
    index_in_row = row.index(part_number, starting_part_index)
    starting_part_index = index_in_row + part_number.length
    parts << { number: part_number, index: index_in_row, end_index: (index_in_row + part_number.length - 1) }
  end

  parts
end

File.readlines('puzzle-input.txt').each do |line, index|
  rows << line
end

valid_gears = []

rows.each_with_index do |row, row_index|
  gears = (0...row.length).find_all { |i| row[i,1] == '*' }
  parts = row_parts(row)

  gears.each do |gear_index|
    adjacent_parts = []

    # in the same row
    parts.each do |part|
      if gear_index == part[:index] - 1 || gear_index == part[:end_index] + 1
        adjacent_parts << part[:number]
      end
    end

    # in row before
    if row_index > 0
      row_before = rows[row_index-1]
      row_before_parts = row_parts(row_before)

      row_before_parts.each do |part|
        if Array(part[:index]..part[:end_index]).intersection(Array((gear_index - 1)..(gear_index + 1))).length > 0
          adjacent_parts << part[:number]
        end
      end
    end

    # in row after
    if row_index < rows.length - 1
      row_after = rows[row_index + 1]
      row_after_parts = row_parts(row_after)
      
      row_after_parts.each do |part|
        if Array(part[:index]..part[:end_index]).intersection(Array((gear_index - 1)..(gear_index + 1))).length > 0
          adjacent_parts << part[:number]
        end
      end
    end

    valid_gears << { gear_index: gear_index, row_index: row_index, adjacent_parts: adjacent_parts} if adjacent_parts.length == 2
  end
end

puts "VALID GEARS: #{valid_gears.count}"
puts "SUM: #{valid_gears.map { |gear| gear[:adjacent_parts][0].to_i * gear[:adjacent_parts][1].to_i }.sum}"