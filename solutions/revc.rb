module Solutions
  module Revc
    def self.solution(input)
      NucleicAcids.dna(input).reverse_complement
    end
  end
end
