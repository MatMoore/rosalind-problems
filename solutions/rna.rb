module Solutions
  module Rna
    SAMPLE_INPUT = "GATGGAACTTGACTACGTAAATT"

    def self.solution(input)
      NucleicAcids.dna(input).rna_transcription
    end
  end
end
