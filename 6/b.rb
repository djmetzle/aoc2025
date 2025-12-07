EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  cells = input.map do |line|
    line.chomp.split('')
  end

  ops = cells.pop
  columns = []
  current = []
  ops.length.times do |i|
    col = cells.map do |row|
      row.pop
    end
    p col
    if col.all? { |c|  c == ' ' || c.nil? }
      p 'sep' 
      columns.unshift(current)
      current = []
    else
      current.push(col.join('').to_i)
    end
  end
  columns.unshift(current)

  [columns, ops.reject { |c| c == ' ' }]
end

def solve(input)
  cells, ops = parse(input)

  ops.zip(cells).map do |values|
    op = values.first
    values = values.last
    values.inject(op)
  end.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 3263827

pp [:solution, solve(INPUT)]
