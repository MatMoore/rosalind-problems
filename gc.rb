require_relative 'lib/nucleic_acids'

sample_dataset = %{
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
}

test_dataset = File.read("gc.txt")

Fasta = Data.define(:id, :sequence) do
  def to_dna
    NucleicAcids.dna(sequence)
  end

  def self.parse(fasta_text)
    Enumerator.new do |y|
      fasta_text.split('>').each do |fasta_entry|
        lines = fasta_entry.lines(chomp: true)
        id = lines[0]
        next if id == "" || id.nil?

        sequence = lines[1..].join

        y.yield Fasta.new(id, sequence)
      end
    end
  end
end

def solve(input)
  fasta_entries = Fasta.parse(input)
  fasta_entries.max { |entry| entry.to_dna.gc_content }
end

answer = solve(test_dataset)
puts answer.id
puts answer.to_dna.gc_content.round(6)


