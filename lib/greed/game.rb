# frozen_string_literal: true

require 'set'
require_relative 'scorer'
require_relative 'dice'
require_relative 'player'

module Greed
  class Game
    WINNING_SCORE = 3000
    GET_IN_SCORE = 300

    def initialize(players, input: $stdin, output: $stdout)
      @players = players
      @current_index = 0
      @final_round = false
      @final_turns_given = Set.new
      @input = input
      @output = output
    end

    def play
      @output.puts "Starting Greed. First to reach #{WINNING_SCORE} triggers final round."
      loop do
        player = @players[@current_index]
        @output.puts "\n--- #{player.name}'s turn ---"
        take_turn(player)

        # Check final round triggering
        if !@final_round && player.score >= WINNING_SCORE
          @final_round = true
          @final_turns_given.add(@current_index) # trigger player's turn counted
          @output.puts "\n*** #{player.name} reached #{player.score} — final round triggered! ***"
          @output.puts "Each other player will now get one final turn."
        end

        # If in final round and a player completes their final turn, mark them.
        if @final_round
          @final_turns_given.add(@current_index)
          # End game when all players have had final turns
          if @final_turns_given.size == @players.size
            winner = @players.max_by(&:score)
            @output.puts "\n=== GAME OVER ==="
            @output.puts "Final scores:"
            @players.each { |p| @output.puts "  #{p.name}: #{p.score}" }
            @output.puts "\nWinner: #{winner.name} with #{winner.score} points."
            return
          end
        end

        advance_player
      end
    end

    private

    def take_turn(player)
      turn_score = 0
      dice_count = 5

      loop do
        @output.puts "Rolling #{dice_count} dice..."
        roll = Dice.roll(dice_count)
        @output.puts "Rolled: #{roll.join(' ')}"
        s, scoring_dice = Scorer.score(roll)
        if s == 0
          @output.puts "Bust! This roll scored 0. Lost turn points."
          turn_score = 0
          break
        else
          turn_score += s
          @output.puts "This roll scored #{s} (scoring dice: #{scoring_dice}). Turn total: #{turn_score}."
          # Determine remaining dice
          if scoring_dice == dice_count
            dice_count = 5
            @output.puts "All dice scored — you may roll all 5 dice again if you choose."
          else
            dice_count -= scoring_dice
            @output.puts "#{dice_count} non-scoring dice remain for next roll."
          end

          # Prompt player for next action
          action = player_decision(player, turn_score, dice_count)
          if action == :stop
            if !player.in_game
              if turn_score >= GET_IN_SCORE
                player.in_game = true
                player.score += turn_score
                @output.puts "#{player.name} got into the game! +#{turn_score} added to total. New total: #{player.score}"
              else
                @output.puts "Turn ended. Need at least #{GET_IN_SCORE} in one turn to get into the game. No points added."
              end
            else
              player.score += turn_score
              @output.puts "#{player.name} stops and banks #{turn_score} points. New total: #{player.score}"
            end
            break
          elsif action == :roll
            next
          end
        end
      end
    end

    def player_decision(player, turn_score, dice_count)
      loop do
        @output.print "(r)oll again or (s)top? > "
        input = @input.gets&.chomp
        unless input
          @output.puts "\nInput closed. Exiting."
          exit
        end
        input = input.downcase.strip
        if input == 'r' || input == 'roll'
          return :roll
        elsif input == 's' || input == 'stop'
          return :stop
        else
          @output.puts "Invalid input. Use 'r' or 's'."
        end
      end
    end

    def advance_player
      @current_index = (@current_index + 1) % @players.size
    end
  end
end
