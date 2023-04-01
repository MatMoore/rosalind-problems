require 'zeitwerk'

module Solutions
end

loader = Zeitwerk::Loader.new
loader.push_dir('./lib')
loader.push_dir('./solutions', namespace: Solutions)
loader.setup
loader.eager_load

solution_modules = [
  Solutions::Dna,
  Solutions::Rna,
  Solutions::Revc,
  Solutions::Fib,
  Solutions::Gc
]

last_index = solution_modules.size - 1

solution_modules.each_with_index do |m, i|
  name = m.name.sub('Solutions::', '')
  lowercase = name.downcase
  test_input = File.read("inputs/#{lowercase}.txt").chomp

  puts name
  puts m.solution(test_input)
  puts "" if i != last_index
end
