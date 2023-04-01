require 'zeitwerk'
require 'optionparser'
require 'pathname'
require 'fileutils'

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

  opts.on("-f", "--force", "Overwrite any existing output") do
    options[:force] = true
  end

  opts.on("-o", "--overwrite-input", "Override input with downloaded files") do
    options[:overwrite] = true
  end
end.parse!

problem_id = ARGV.first

solution_modules = [
  Solutions::Dna,
  Solutions::Rna,
  Solutions::Revc,
  Solutions::Fib,
  Solutions::Gc,
  Solutions::Hamm,
]

if problem_id
  solution_modules = solution_modules.filter { |m| m.name.downcase == "solutions::#{problem_id}" }
end

last_index = solution_modules.size - 1

solution_modules.each_with_index do |m, i|
  name = m.name.sub('Solutions::', '')
  lowercase = name.downcase

  if options[:overwrite]
    download_path = Pathname.new(ENV['HOME']) + 'Downloads'
    download_path.glob("rosalind_#{lowercase}.txt").each do |pathname|
      new_filename = pathname.basename.sub('rosalind_', '')
      new_path = Pathname.new('inputs') + new_filename
      FileUtils.cp(pathname, new_path)
    end
  end

  test_input = File.read("inputs/#{lowercase}.txt").chomp

  output_path = "outputs/#{lowercase}.txt"

  original_output = nil

  unless options[:force]
    begin
      original_output = File.read(output_path)
    rescue Errno::ENOENT
    end
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
