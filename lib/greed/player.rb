# frozen_string_literal: true

module Greed
  class Player
    attr_reader :name
    attr_accessor :score, :in_game

    def initialize(name)
      @name = name
      @score = 0
      @in_game = false
    end

    def to_s
      "#{name} (#{score}#{in_game ? '' : ' - NOT IN GAME'})"
    end
  end
end
