module Solutions
  module Hamm
    def self.solution(input)
      a = NucleicAcids.dna(input.lines.first.chomp)
      b = NucleicAcids.dna(input.lines.last.chomp)

      a.hamming_distance(b)
    end
  end
end
