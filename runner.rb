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
  Solutions::Iprb,
  Solutions::Prot,
  Solutions::Subs,
  Solutions::Cons,
]

if problem_id
  solution_modules = solution_modules.filter { |m| m.name.downcase == "solutions::#{problem_id}" }
end

last_index = solution_modules.size - 1

class SolutionRunner
  def initialize(m)
    @m = m
    @name = m.name.sub('Solutions::', '')
    @id = name.downcase
  end

  attr_reader :id
  attr_reader :name

  def overwrite_input
    download_path = Pathname.new(ENV['HOME']) + 'Downloads'
    download_path.glob("rosalind_#{id}.txt").each do |pathname|
      new_filename = pathname.basename.sub('rosalind_', '')
      new_path = Pathname.new('inputs') + new_filename
      FileUtils.cp(pathname, new_path)
    end
  end

  def original_output
    @original ||= File.read(output_path)
  rescue Errno::ENOENT
  end

  def run
    output = m.solution(load_test_input).to_s + "\n"

    if original_output.nil?
      File.write(output_path, output)
      [:new, output]
    elsif original_output != output
      [:changed, output]
    else
      [:unchanged, output]
    end
  end

  private

  attr_reader :m

  def load_test_input
    File.read("inputs/#{id}.txt").chomp
  end

  def output_path
    "outputs/#{id}.txt"
  end
end

solution_modules.each_with_index do |m, i|
  solution_runner = SolutionRunner.new(m)

  if options[:overwrite]
    solution_runner.overwrite_input
  end

  original_output = options[:force] ? nil : solution_runner.original_output

  result, output = solution_runner.run
  case result
  when :failed
    puts "#{solution_runner.name} FAILED"
  else
    puts solution_runner.name unless problem_id
  end

  puts output
  puts "" if i != last_index
end
