module Solutions::Cons
  def self.solution(input)
    profile_matrix = ProfileMatrix.new
    Fasta.parse(input).each do |fasta|
      profile_matrix.add_string(fasta.to_dna)
    end

    puts profile_matrix.consensus.join
    puts profile_matrix.to_s
  end
end
