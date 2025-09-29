# frozen_string_literal: true

module Greed
  class Scorer
    # Returns [score, scoring_dice_count]
    def self.score(dice)
      counts = Hash.new(0)
      dice.each { |d| counts[d] += 1 }

      score = 0
      scoring_dice = 0

      # Triplets
      (1..6).each do |face|
        if counts[face] >= 3
          if face == 1
            score += 1000
          else
            score += face * 100
          end
          counts[face] -= 3
          scoring_dice += 3
        end
      end

      # Remaining ones and fives
      if counts[1] > 0
        score += counts[1] * 100
        scoring_dice += counts[1]
      end

      if counts[5] > 0
        score += counts[5] * 50
        scoring_dice += counts[5]
      end

      [score, scoring_dice]
    end
  end
end
