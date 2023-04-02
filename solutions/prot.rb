module Solutions::Prot
  def self.solution(input)
    messenger_rna = GeneticString.rna(input)
    Ribosome.new.grow_protein(messenger_rna)
  end
end
