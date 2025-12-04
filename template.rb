EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    line
  end
end

def solve(input)
  problem = parse(input)
  return 1
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 1

pp [:solution, solve(INPUT)]
