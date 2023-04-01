module Solutions
  module Revc
    SAMPLE_INPUT = "AAAACCCGGT"

    def self.solution(input)
      NucleicAcids.dna(input).reverse_complement
    end
  end
end
