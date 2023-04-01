module Solutions
  module Gc
    Fasta = Data.define(:id, :sequence) do
      def to_dna
        NucleicAcids.dna(sequence)
      end

      def self.parse(fasta_text)
        Enumerator.new do |y|
          fasta_text.split('>').each do |fasta_entry|
            lines = fasta_entry.lines(chomp: true)
            id = lines[0]
            next if id == "" || id.nil?

            sequence = lines[1..].join

            y.yield Fasta.new(id, sequence)
          end
        end
      end
    end

    def self.solution(input)
      fasta_entries = Fasta.parse(input)
      answer = fasta_entries.max { |entry| entry.to_dna.gc_content }

      "#{answer.id}\n#{answer.to_dna.gc_content.round(6)}"
    end
  end
end

