EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input = input.map(&:chomp)
  split = input.find_index('')
  ranges = input[0...split].map do |str|
    start,stop = str.split('-').map(&:to_i)
    Range.new(start, stop)
  end
  return ranges
end

def solve(input)
  ranges = parse(input)

  found = 1
  while found > 0
    subranges = []

    ranges.combination(2).each do |range1, range2|
      if range1.overlap?(range2)
        least = [range1.begin, range2.begin].min
        most = [range1.end, range2.end].max
        subranges.push(Range.new(least, most))
        ranges.delete(range1)
        ranges.delete(range2)
      end
    end

    ranges = ranges.concat(subranges).uniq
    found = subranges.length
  end

  return ranges.map(&:size).sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 14

pp [:solution, solve(INPUT)]
