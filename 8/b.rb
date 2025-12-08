EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map.with_index do |line, i|
    [i, line.chomp.split(',').map(&:to_i)]
  end
end

def distance(one, two)
  Math.sqrt(
    (one[0] - two[0])**2 + (one[1] - two[1])**2 + (one[2] - two[2])**2
  )
end

def solve(input, connections)
  problem = parse(input)
  junctions = problem.map(&:first)
  circuits = junctions.map do |j|
    Set.new([j])
  end
  pairs = problem.combination(2).map do |pair|
    [distance(pair[0][1], pair[1][1]), pair]
  end

  connected = 0
  pairs.sort_by { |p| p[0] }.each do |pair|
    one = pair[1][0]
    two = pair[1][1]

    existing = circuits.select do |circuit|
      circuit.include?(one[0]) || circuit.include?(two[0])
    end
    if existing.length == 2
      joined = existing[0].merge(existing[1])
      circuits.delete(existing[0])
      circuits.delete(existing[1])
      circuits.push(joined)
    elsif existing.length == 1
      next if existing.include?(one[0]) && existing.include?(two[0])

      existing.first.add(one[0])
      existing.first.add(two[0])
    else
      p existing
      raise :wat
    end

    if circuits.length == 1
      return one[1][0] * two[1][0]
    end
  end
end

example = solve(EXAMPLE, 10)
raise "Incorrect #{example}" unless example == 25272

pp [:solution, solve(INPUT, 1000)]
