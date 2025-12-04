EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

PENCIL = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
].freeze

def parse(input)
  input.map do |line|
    line.chomp.split('').map { |c| c == '@' }
  end
end

def remove(layout)
  next_layout = layout.clone
  rows = layout.count
  count = 0

  layout.each_with_index do |row, i|
    columns = row.count
    row.each_with_index do |column, j|
      adj = 0
      PENCIL.each do |offset|
        offset_row = offset[0] + i
        offset_column = offset[1] + j

        next unless (offset_row >= 0) && (offset_row < rows)
        next unless (offset_column >= 0) && (offset_column < columns)

        adj += 1 if layout[offset_row][offset_column]
      end
      if column && adj < 4
        count += 1
        next_layout[i][j] = false
      end
    end
  end
  layout = next_layout
  return count
end

def solve(input)
  layout = parse(input)
  count = 0
  last_removed = 999_999
  until last_removed.zero?
    last_removed = remove(layout)
    count += last_removed
  end
  count
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 43

pp [:solution, solve(INPUT)]
