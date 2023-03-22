require_relative 'lib/nucleic_acids'

sample = "GATGGAACTTGACTACGTAAATT"
test = File.read("rna.txt").chomp

def solution(input)
  NucleicAcids.dna(input).rna_transcription
end

puts solution(sample)
puts solution(test)
