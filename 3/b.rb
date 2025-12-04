EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse(input)
  input.map do |line|
    line.strip.split('')
  end
end

def solve(input)
  banks = parse(input)
  banks.map do |bank|
    p bank.join('').to_i
    while bank.length > 12
      max = 0
      max_index = 0
      bank.each_with_index do |el, i|
        copy = bank.clone
        copy.delete_at(i)
        val = copy.join('').to_i
        if val > max
          max = val
          max_index = i
        end
      end
      bank.delete_at(max_index)
    end
    bank.join('').to_i
  end.sum
end


example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 3121910778619

pp [:solution, solve(INPUT)]
