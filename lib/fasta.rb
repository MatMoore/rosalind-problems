# The FASTA format looks like this:
#
# >Taxon1
# CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
# TCCCACTAATAATTCTGAGG
# >Taxon2
# CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
# ATATCCATTTGTCAGCAGACACGC
#
# Each string is an identifier followed by a sequence.
# Sequences may be split over multiple lines.

Fasta = Data.define(:id, :sequence) do
  def to_dna
    GeneticString.dna(sequence)
  end

  def self.parse(fasta_text)
    Enumerator.new do |y|
      fasta_text.split('>').each do |fasta_entry|
        lines = fasta_entry.lines(chomp: true)
        id = lines[0]&.strip
        next if id == "" || id.nil?

        sequence = lines[1..].join

        y.yield Fasta.new(id, sequence)
      end
    end
  end
end
