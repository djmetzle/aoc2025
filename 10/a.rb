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

def parse(input)
  input.map do |line|
    parts = line.chomp.split(' ')
    lights = parse_lights(parts.shift)
    joltages = parts.pop
    buttons = parse_buttons(parts)
    [lights, buttons, joltages]
  end
end

def states(input, buttons)
  buttons.map do |button|
    result = input.clone
    button.each { |i| result[i] = !result[i] }
    result
  end
end

def min_presses(target, buttons)
  p target, buttons
  off = Array.new(target.length) { false }
  current_states = states(off, buttons)
  counter = 1
  until current_states.include? target
    counter += 1
    p counter
    current_states = current_states.map { |state| states(state, buttons) }.flatten(1).uniq
  end
  counter
end

def solve(input)
  machines = parse(input)
  machines.map do |machine|
    lights, buttons, joltages = machine
    presses = min_presses(lights, buttons)
    p [:presses, presses]
    presses
  end.sum
end

example = solve(EXAMPLE)
raise "Incorrect #{example}" unless example == 7

pp [:solution, solve(INPUT)]
