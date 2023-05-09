module Solutions::Grph
  def self.solution(input)
    o3 = []

    suffix_to_id = {}

    entries = Fasta.parse(input)

    entries.each do |fasta_entry|
      current_sequence = fasta_entry.to_dna.sequence
      suffix = current_sequence[-3..]

      suffix_to_id[suffix] ||= []
      suffix_to_id[suffix] << fasta_entry.id
    end

    entries.each do |fasta_entry|
      current_sequence = fasta_entry.to_dna.sequence
      prefix = current_sequence[0, 3]

      matches = suffix_to_id[prefix] || []
      matches.each do |matching_id|
        next if matching_id == fasta_entry.id

        o3 << [matching_id, fasta_entry.id]
      end
    end

    o3.map { |pair| pair.join(' ') }.join("\n")
  end
end
