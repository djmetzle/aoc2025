EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  Hash[input.map do |line|
    start, outputs = line.split(':')
    [start, outputs.chomp.split(' ')]
  end]
end

def solve(input)
  problem = parse(input)
  p problem
  paths = [['you']]
  until paths.all? { |path| path.last == 'out' }
    p paths
    next_paths = []
    paths.each do |path|
      input = path.last
      unless input != 'out'
        next_paths.push(path)
        next
      end

      outputs = problem[input]
      outputs.each do |output|
        next_paths.push(path.clone.push(output))
      end
    end
    paths = next_paths
    p paths
  end
  paths.length
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 5

pp [:solution, solve(INPUT)]
