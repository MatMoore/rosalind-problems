# Mortal rabbits
#
# In this scenario, rabbits have a fixed life span of `m`.
# Each child pair matures into an adult pair within 1
# month, and each adult pair produces breeding pairs every month.
#
# We can describe the number of adult rabbit pairs, `A`, and
# the number of child rabbit pairs `C` with the following
# recurrance relation:
# A_i = C_{i-1} + A_{i-1} - A_{i-m}
# C_i = A_{i-1}
#
# After 6 months, the population will evolve as folows:
# Month 1: 1 child           = 1
# Month 2: 1 adult           = 1
# Month 3: 1 adult + 1 child = 2
# Month 4: 1 adult + 1 child = 2
# Month 5: 2 adult + 1 child = 3
# Month 6: 2 adult + 2 child = 4
module Solutions
  module Fibd
    def self.rabbits(generation:, life_span:, litter_size: 1)
       # this is a sliding window of size `life_span`, so that
       # we can keep track of which rabbits should die in any
       # given generation
      children = [1]

      adults = 0
      2.upto(generation) do |i|
        current_adults = adults
        dead = children[-life_span] || 0
        grown = children[-1]
        children << current_adults * litter_size
        adults = current_adults - dead + grown

        children.shift if children.size > life_span
        #puts "#{i} #{adults.inspect}, #{children.inspect}"
      end

      adults + children[-1]
    end

    def self.solution(input)
      n, m = input.split(' ').map { |i| i.to_i }
      litter_size = 1
      rabbits(generation: n, litter_size: 1, life_span: m)
    end
  end
end
