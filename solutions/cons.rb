module Solutions::Cons
  def self.solution(input)
    profile_matrix = ProfileMatrix.new
    Fasta.parse(input).each do |fasta|
      profile_matrix.add_string(fasta.to_dna)
    end

    return profile_matrix.consensus.join + "\n" + profile_matrix.to_s
  end
end
