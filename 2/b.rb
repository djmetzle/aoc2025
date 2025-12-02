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
  seen = Set.new
  loop do
    str = s.to_s
    twice = (str + str).to_i
    break if twice > upper_bound

    search = []

    repeats = 1
    loop do
      repeats += 1
      val = (str * repeats).to_i

      if val <= upper_bound && !seen.include?(val)
        seen.add(val)
        search.push(val)
      end
      break if val > upper_bound
    end

    search.each do |check|
      if ranges.any? { |range| range.include?(check) }
        sum += check
      end
    end

    s += 1
  end

  sum
end

example = solve(EXAMPLE)
raise "Incorrect: #{example}" unless example == 4_174_379_265

pp "Solution:"
pp solve(INPUT)
