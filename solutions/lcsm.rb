module Solutions::Lcsm
  def self.solution(input)
    fasta_strings = Fasta.parse(input).to_a
    longest_substring_length = 1
    longest_substring = nil

    needle = fasta_strings.first.sequence
    haystack = fasta_strings[1..].map(&:sequence)

    Utils.longest_matching_slice(needle) { |motif| haystack.all? { |s| s.include?(motif) } }
  end
end
