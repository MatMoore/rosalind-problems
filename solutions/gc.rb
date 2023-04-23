module Solutions
  module Gc
    def self.solution(input)
      fasta_entries = Fasta.parse(input)
      answer = fasta_entries.max { |entry| entry.to_dna.gc_content }

      "#{answer.id}\n#{answer.to_dna.gc_content.round(6)}"
    end
  end
end

