EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    line.chomp.split(',').map(&:to_i)
  end
end

def solve(input)
  corners = parse(input)
  return corners.zip(corners.rotate, corners.rotate.rotate).map do |edges|
    first, second, third = edges

    x1 = [first[0], second[0], third[0]].min
    x2 = [first[0], second[0], third[0]].max

    y1 = [first[1], second[1], third[1]].min
    y2 = [first[1], second[1], third[1]].max

    (x2-x1).abs * (y2 -y1).abs
  end.max
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 24

p "STUMPED"

#pp [:solution, solve(INPUT)]
