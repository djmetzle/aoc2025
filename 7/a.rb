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
  beams = [start]
  total_splits = 0
  splits.each do |splitters|
    p beams
    p splitters
    out_beams = []
    beams.each do |beam|
      if splitters.any? { |splitter| beam == splitter }
        out_beams.push(beam - 1)
        out_beams.push(beam + 1)
        total_splits += 1
      else
        out_beams.push(beam)
      end
    end
    beams = out_beams.uniq
  end
  total_splits
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 21

pp [:solution, solve(INPUT)]
