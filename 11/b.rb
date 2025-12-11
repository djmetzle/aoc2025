EXAMPLE = File.new('example.txt', 'r').readlines
EXAMPLE2 = File.new('example2.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  Hash[input.map do |line|
    start, outputs = line.split(':')
    [start, outputs.chomp.split(' ')]
  end]
end

Path = Struct.new(:prev, :last, :dac, :fft)

$memo = {}

def paths(problem, path)
  return $memo[path] if $memo[path]

  if path.last == 'out'
    return (path.dac && path.fft) ? 1 : 0
  end

  outputs = problem[path.last]
  ret = outputs.sum do |output|
    next_path = Path.new(path.last, output, path.dac, path.fft)
    next_path.dac = true if output == 'dac'
    next_path.fft = true if output == 'fft'
    paths(problem, next_path)
  end

  $memo[path] = ret
  return ret
end

def solve(input)
  problem = parse(input)
  p problem
  $memo = {}
  start = Path.new(nil, 'svr', false, false)
  return paths(problem, start)
end

example = solve(EXAMPLE2)
raise "Incorrect #{example}" unless example == 2

pp [:solution, solve(INPUT)]
