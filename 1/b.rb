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

    next_pos = pos
    passes = 0

    (1..n).each do
      next_pos = next_pos.send(op, 1)
      if (next_pos % 100).zero?
        puts 'pass'
        passes += 1
      end
    end

    p [op, n, pos, next_pos, passes]
    pos = next_pos % 100
    zeros += passes
  end
  zeros
end

example = solve(EXAMPLE)
raise "Incorrect: #{example}" unless example == 6

test = solve(["R1000"])
raise "Incorrect: #{test}" unless test == 10

pp solve(INPUT)
