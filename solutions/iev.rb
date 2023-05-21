module Solutions::Iev
  def self.solution(input)
    # 0. AA-AA -> 100% dominant
    # 1. AA-Aa -> 100% dominant
    # 2. AA-aa -> 100% dominant
    # 3. Aa-Aa -> 75% dominant
    # 4. Aa-aa -> 50% domminant
    # 5. aa-aa -> 0% dominant
    genotype_counts = input.split(' ').map { |i| i.to_i }

    (
      genotype_counts[0] +
      genotype_counts[1] +
      genotype_counts[2] +
      genotype_counts[3] * 0.75 +
      genotype_counts[4] * 0.5
    ) * 2
  end
end
