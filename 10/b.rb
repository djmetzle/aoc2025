require 'rulp'

EXAMPLE = File.new('example.txt', 'r').readlines
INPUT = File.new('input.txt', 'r').readlines

def parse_lights(lights)
  lights = lights.split('')
  lights.shift
  lights.pop
  lights.map do |light|
    case light
    when '.'
      false
    when '#'
      true
    end
  end
end

def parse_buttons(buttons)
  buttons = buttons.map { |button| button.split('') }
  buttons.each(&:pop)
  buttons.each(&:shift)
  buttons.map do |button|
    button.reject { |b| b == ',' }.map(&:to_i)
  end
end

def parse_joltages(joltages)
  joltages = joltages.split('')
  joltages.pop
  joltages.shift
  joltages.join('').split(',').map(&:to_i)
end

def parse(input)
  input.map do |line|
    parts = line.chomp.split(' ')
    lights = parse_lights(parts.shift)
    joltages = parse_joltages(parts.pop)
    buttons = parse_buttons(parts)
    [lights, buttons, joltages]
  end
end

def min_presses(target, buttons)
  p target
  p buttons
  variables = buttons.map.with_index do |t, i|
    Button_i(i)
  end

  given[
    variables.map { |i| i >= 0 }
  ]

  constraints = target.map.with_index do |t,j|
    buttons.map.with_index do |b, i|
      p [j, i, b, (b.include?(j) ? 1 : 0)]
      (b.include?(j) ? 1 : 0) * Button_i(i)
    end.inject(&:+) == t
  end

  problem = Rulp::Min(variables.inject(&:+))
  problem[constraints]
  problem.solve.to_i
end

def solve(input)
  machines = parse(input)
  machines.map do |machine|
    lights, buttons, joltages = machine
    presses = min_presses(joltages, buttons)
    p [:presses, presses]
    presses
  end.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 33

p [:example, example]

pp [:solution, solve(INPUT)]
