EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  start = input.first.split('').find_index { |c| c == 'S' }
  input.delete_at(0)
  splits = input.map do |line|
    line.split('').map.with_index do |c, i|
      c == '^' ? i : nil
    end.reject(&:nil?)
  end

  [start, splits]
end

def solve(input)
  start, splits = parse(input)
  p start, splits
  beams = { start => 1 }
  splits.each do |splitters|
    p beams
    out_beams = {}
    p splitters
    beams.each do |beam, n|
      if splitters.any? { |splitter| beam == splitter }
        out_beams[beam - 1] ||= 0
        out_beams[beam + 1] ||= 0

        out_beams[beam - 1] += n
        out_beams[beam + 1] += n
      else
        out_beams[beam] ||= 0
        out_beams[beam] += n
      end
    end
    beams = out_beams
  end
  beams.values.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 40

pp [:solution, solve(INPUT)]
