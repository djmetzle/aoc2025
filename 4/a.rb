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

def solve(input)
  layout = parse(input)
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
      count += column && adj < 4 ? 1 : 0
    end
  end
  count
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 13

pp [:solution, solve(INPUT)]
