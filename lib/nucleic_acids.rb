module NucleicAcids
  DNA = Data.define(:sequence) do
    # RNA transcription takes a strand of DNA and uses it
    # as a template to create a messanger RNA (mRNA).
    # Uracil is used instead of Thymine.
    def rna_transcription
      NucleicAcids.rna(sequence.gsub('T', 'U'))
    end

    # Reverse the sequence and take the complement of each nucleotide
    # A <=> T
    # C <=> G
    # Given the sequence of DNA in one strand of the double helix, this will
    # tell you the other one that it is bonded to.
    def reverse_complement
      NucleicAcids.dna(sequence.reverse.tr('ACGT', 'TGCA'))
    end

    # GC content is the percentage of the nucleotides that are either G or C.
    def gc_content
      gc_count = sequence.chars.filter { |char| char == "G" || char == "C" }.count
      (gc_count * 100).fdiv(sequence.size)
    end
  end

  RNA = Data.define(:sequence)

  class InvalidNucleotide < StandardError
  end

  private_constant :DNA
  private_constant :RNA

  def self.dna(sequence)
    throw InvalidNucleotide unless sequence =~ /^[ACGT]+$/

    DNA.new(sequence)
  end

  def self.rna(sequence)
    throw InvalidNucleotide unless sequence =~ /^[ACGU]+$/

    RNA.new(sequence)
  end
end
