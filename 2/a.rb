EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.first.chomp.split(',').map do |range|
    range.split('-').map(&:to_i)
  end.map do |start, stop|
    Range.new(start, stop)
  end
end

def solve(input)
  ranges = parse(input)
  p ranges
  upper_bound = ranges.max_by(&:max).max
  sum = 0
  s = 1
  loop do
    twice = (s.to_s + s.to_s).to_i
    break if twice > upper_bound

    sum += twice if ranges.any? { |range| range.include?(twice) }

    s += 1
  end

  sum
end

example = solve(EXAMPLE)
raise "Incorrect: #{example}" unless example == 1_227_775_554

pp solve(INPUT)
