module Solutions
  module Revc
    def self.solution(input)
      GeneticString.dna(input).reverse_complement
    end
  end
end
