# A ribosome is a structure in the cell that creates peptides
# (chains of amino acids), which form proteins.
#
# The ribosome takes messanger RNA (mRNA) and operates on 3 nucleotides
# at a time.
# Each chunk of 3 nucelotides is called a codon, and their complement
# is called an anticodon.
# The codon of the mRNA bonds with an anticodon attached to another molecule,
# called the transfer RNA (tRNA). On the other end of the tRNA is
# an amino acid, so the tRNA works like a sort of lookup table that
# translates codons to amino acids.
class Ribosome
  def initialize
    @codon_to_amino_acid = {
      "UUU" => "F",
      "CUU" => "L",
      "AUU" => "I",
      "GUU" => "V",
      "UUC" => "F",
      "CUC" => "L",
      "AUC" => "I",
      "GUC" => "V",
      "UUA" => "L",
      "CUA" => "L",
      "AUA" => "I",
      "GUA" => "V",
      "UUG" => "L",
      "CUG" => "L",
      "AUG" => "M",
      "GUG" => "V",
      "UCU" => "S",
      "CCU" => "P",
      "ACU" => "T",
      "GCU" => "A",
      "UCC" => "S",
      "CCC" => "P",
      "ACC" => "T",
      "GCC" => "A",
      "UCA" => "S",
      "CCA" => "P",
      "ACA" => "T",
      "GCA" => "A",
      "UCG" => "S",
      "CCG" => "P",
      "ACG" => "T",
      "GCG" => "A",
      "UAU" => "Y",
      "CAU" => "H",
      "AAU" => "N",
      "GAU" => "D",
      "UAC" => "Y",
      "CAC" => "H",
      "AAC" => "N",
      "GAC" => "D",
      "UAA" => :stop,
      "CAA" => "Q",
      "AAA" => "K",
      "GAA" => "E",
      "UAG" => :stop,
      "CAG" => "Q",
      "AAG" => "K",
      "GAG" => "E",
      "UGU" => "C",
      "CGU" => "R",
      "AGU" => "S",
      "GGU" => "G",
      "UGC" => "C",
      "CGC" => "R",
      "AGC" => "S",
      "GGC" => "G",
      "UGA" => :stop,
      "CGA" => "R",
      "AGA" => "R",
      "GGA" => "G",
      "UGG" => "W",
      "CGG" => "R",
      "AGG" => "R",
      "GGG" => "G"
    }
  end

  def grow_protein(messenger_rna)
    protein = ""

    messenger_rna.sequence.chars.each_slice(3) do |codon|
      amino_acid = codon_to_amino_acid[codon.join]
      return protein if amino_acid == :stop

      protein << amino_acid
    end

    protein
  end

  private

  attr_reader :codon_to_amino_acid
end
