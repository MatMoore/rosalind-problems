module NucleicAcids
  DNA = Data.define(:sequence) do
    # RNA transcription takes a strand of DNA and uses it
    # as a template to create a messanger RNA (mRNA).
    # Uracil is used instead of Thymine.
    def rna_transcription
      NucleicAcids.rna(sequence.gsub('T', 'U'))
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
