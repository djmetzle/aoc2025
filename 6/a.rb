EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  cells = input.map do |line|
    line.chomp.split(' ')
  end

  ops = cells.pop
  cells = cells.map do |row|
    row.map(&:to_i)
  end

  [cells.transpose, ops]
end

def solve(input)
  cells, ops = parse(input)
  p [cells, ops]
  cells.zip(ops).map do |col, op|
    col.inject(op)
  end.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 4_277_556

pp [:solution, solve(INPUT)]
