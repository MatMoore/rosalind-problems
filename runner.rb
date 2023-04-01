require 'zeitwerk'
require 'optionparser'

module Solutions
end

loader = Zeitwerk::Loader.new
loader.push_dir('./lib')
loader.push_dir('./solutions', namespace: Solutions)
loader.setup
loader.eager_load

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: runner.rb [options] [PROBLEM_ID]"

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

problem_id = ARGV.first

solution_modules = [
  Solutions::Dna,
  Solutions::Rna,
  Solutions::Revc,
  Solutions::Fib,
  Solutions::Gc
]

if problem_id
  solution_modules = solution_modules.filter { |m| m.name.downcase == "solutions::#{problem_id}" }
end

last_index = solution_modules.size - 1

solution_modules.each_with_index do |m, i|
  name = m.name.sub('Solutions::', '')
  lowercase = name.downcase

  test_input = File.read("inputs/#{lowercase}.txt").chomp

  output_path = "outputs/#{lowercase}.txt"

  begin
    original_output = File.read(output_path)
  rescue Errno::ENOENT
    original_output = nil
  end

  output = m.solution(test_input).to_s + "\n"

  if original_output.nil?
    File.write(output_path, output)
  elsif original_output != output
    puts "#{name} FAILED"
  else
    puts name unless problem_id
  end

  puts output
  puts "" if i != last_index
end
