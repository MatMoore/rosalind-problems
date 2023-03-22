sample = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
test = File.read("dna.txt")

def solution(input)
  counts = input.chars.each_with_object(Hash.new(0)) do |i, hash|
    hash[i] += 1
  end

  "#{counts['A']} #{counts['C']} #{counts['G']} #{counts['T']}"
end

puts solution(sample)
puts solution(test)
