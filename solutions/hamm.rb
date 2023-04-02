module Solutions
  module Hamm
    def self.solution(input)
      a = GeneticString.dna(input.lines.first.chomp)
      b = GeneticString.dna(input.lines.last.chomp)

      a.hamming_distance(b)
    end
  end
end
