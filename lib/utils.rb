module Utils
  # Find the longest slice of the collection or string
  # for which the block returns true.
  def self.longest_matching_slice(collection, &block)
    collection_size = collection.size
    window_size = 1
    result = nil

    # Move a sliding window across the collection
    (0...collection_size).each do |i|
      while window_size + i <= collection_size
        window = collection[i, window_size]

        # Check if we have a match for all haystack strings
        if block.call(window)
          result = window

          # Keep increasing the window size until it no longer matches
          window_size += 1
        else
          # Advance the window
          break
        end
      end
    end

    result
  end
end
