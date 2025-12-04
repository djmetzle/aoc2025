EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    line.strip.split('')
  end
end

def solve(input)
  banks = parse(input)
  banks.map do |bank|
    bank
      .combination(2)
      .map { |pair| pair.join('').to_i }
      .max
  end.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 357

pp [:solution, solve(INPUT)]
