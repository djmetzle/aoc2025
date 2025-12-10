EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    line.chomp.split(',').map(&:to_i)
  end
end

def solve(input)
  corners = parse(input)
  corners.combination(2).map do |left, right|
    p [left, right]
    x = (left[0] - right[0]).abs + 1
    y = (left[1] - right[1]).abs + 1
    x * y
  end.max
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 50

pp [:solution, solve(INPUT)]
