module Solutions::Iprb
  def self.solution(input)
    k, m, n = input.split(' ').map { |x| x.to_f }
    total = k + m + n

    p_first_parent_dominant = k / total
    p_recessive_dominant = n / total * k / (total - 1)
    p_recessive_heterozygous = n / total * m / (total - 1)
    p_heterozygous_dominant = m / total * k / (total - 1)
    p_heterozygous_recessive = m / total * n / (total - 1)
    p_heterozygous_heterozygous = m / total * (m-1) / (total - 1)

    (
      p_first_parent_dominant +
      p_recessive_dominant +
      p_recessive_heterozygous * 0.5 +
      p_heterozygous_dominant +
      p_heterozygous_recessive * 0.5 +
      p_heterozygous_heterozygous * 0.75
    )
  end
end
