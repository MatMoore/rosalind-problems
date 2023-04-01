module Solutions
  module Fib
    def self.fibonacci(generation:, i0: 1, i1: 1, litter_size: 1)
      3.upto(generation) do
        temp = i1 + (i0 * litter_size)
        i0 = i1
        i1 = temp
      end

      i1
    end

    def self.solution(input)
      n, k = input.split(' ').map { |i| i.to_i }
      fibonacci(i0: 1, i1: 1, generation: n, litter_size: k)
    end
  end
end

#puts fibonacci(i0: 1, i1: 1, generation: 5, litter_size: 3)
# 1. 1
# 2. 1
# -
# 3. 4
# 4. 7
# 5. 19

#puts fibonacci(i0: 1, i1: 1, generation: n, litter_size: k)

