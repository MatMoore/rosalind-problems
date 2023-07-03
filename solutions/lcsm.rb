module Solutions::Lcsm
  def self.solution(input)
    fasta_strings = Fasta.parse(input).to_a
    longest_substring_length = 1
    longest_substring = nil

    needle = fasta_strings.first.sequence
    haystack = fasta_strings[1..].map(&:sequence)
    needle_length = needle.chars.size

    # Move a sliding window across the needle string
    (0...needle_length).each do |i|
      substring_size = [longest_substring_length, 1].max

      while substring_size + i <= needle_length
        substring = needle[i, substring_size]

        # Check if we have a match for all haystack strings
        if haystack.all? { |s| s.include?(substring) }
          longest_substring_length = substring.size
          longest_substring = substring

          # Keep increasing the window size until it no longer matches
          substring_size += 1
        else
          # Advance the window
          break
        end
      end
    end

    longest_substring
  end
end
