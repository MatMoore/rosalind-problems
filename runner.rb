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
    puts name
  end

  puts output
  puts "" if i != last_index
end
