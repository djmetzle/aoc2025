EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input = input.map(&:chomp)
  split = input.find_index('')
  ranges = input[0...split].map do |str|
    start,stop = str.split('-').map(&:to_i)
    Range.new(start, stop)
  end
  ingredients = input[(split+1)...input.length].map(&:to_i)
  return [ranges, ingredients]
end

def solve(input)
  ranges, ingredients = parse(input)
  return ingredients.count do |ingredient|
    ranges.any? do |range|
      range.include?(ingredient)
    end
  end
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 3

pp [:solution, solve(INPUT)]
