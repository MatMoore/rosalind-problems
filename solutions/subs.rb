module Solutions::Subs
  def self.solution(input)
    haystack, motif = input.lines.map { |l| l.chomp }

    GeneticString.dna(haystack).find_motif(motif)
  end
end
