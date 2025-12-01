EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    match_data = line.match(/(?<dir>(L|R))(?<n>\d+)/)
    op = case match_data[:dir]
    when 'L'
      '-'
    when 'R'
      '+'
    else
      throw 'wat'
    end
    [op, match_data[:n].to_i]
  end
end

def solve(input)
  zeros = 0
  pos = 50
  parse(input).each do |turn|
    op, n = turn
    pos = pos.send(op, n) % 100
    if pos.zero?
      zeros += 1
    end
    p pos
  end
  zeros
end

example = solve(EXAMPLE)
raise 'Incorrect' unless example == 3

pp solve(INPUT)
