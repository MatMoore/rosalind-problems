require_relative 'lib/nucleic_acids'

sample = "AAAACCCGGT"
test = File.read("revc.txt").chomp

def solution(input)
  NucleicAcids.dna(input).reverse_complement
end

puts solution(sample)
puts solution(test)
