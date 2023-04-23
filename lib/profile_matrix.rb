# A profile matrix stores the number of times a nucleotide
# occurs in a given position across a set of gentic strings.
#
# For example:
# A   5 1 0 0 5 5 0 0
# C   0 0 1 4 2 0 6 1
# G   1 1 6 3 0 1 0 0
# T   1 5 0 0 0 1 1 6

class ProfileMatrix
  class StringSizeError < StandardError
  end

  def initialize
    @nucleotides = ['A', 'C', 'G', 'T']
    @string_size = nil
    @counts = nil
  end

  def add_string(string)
    if string_size.nil?
      init_counts(string.sequence.size)
    else
      raise StringSizeError if string.sequence.size != string_size
    end

    string.sequence.each_char.with_index do |nucleotide, i|
      @counts[i][nucleotide] += 1
    end
  end

  # The most common nucleotide in each position
  def consensus
    @counts.map { |c| c.to_a.max_by { |(k, v)| v }.first }
  end

  # A single row in the profile matrix
  def nucleotide_count(nucleotide)
    @counts.map { |c| c[nucleotide] }
  end

  def to_s
    rows = @nucleotides.map do |n|
      "#{n}: #{nucleotide_count(n).join(" ")}"
    end

    rows.join("\n")
  end

  private

  attr_reader :string_size

  def init_counts(size)
    @string_size = size
    @counts = Array.new(size) { Hash.new { 0 } }
  end
end
