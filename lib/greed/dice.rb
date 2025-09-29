# frozen_string_literal: true

module Greed
  class Dice
    def self.roll(n)
      Array.new(n) { rand(1..6) }
    end
  end
end
