require 'tictactoe'
require 'tictactoe/cli/options/cli_asker'
require 'tictactoe/cli/options/play_again_option'
require 'tictactoe/cli/options/board_type_selection'
require 'tictactoe/cli/options/players_selection'
require 'tictactoe/cli/board_formatter'
require 'tictactoe/players/human'

module Tictactoe
  module Cli
    class Runner
      def initialize(input=$stdin, output=$stdout, random=Random.new)
        @input = input
        @output = output
        @random = random

        @asker = Options::CliAsker.new(input, output)
        @board_type = Options::BoardTypeSelection.new(asker)
        @who_will_play = Options::PlayersSelection.new(asker)
        @play_again = Options::PlayAgainOption.new(asker)
      end

      def run
        begin 
          reset_game

          print_board
          begin
            make_move
            print_board
          end until is_game_finished?

          print_result
        end while play_again?
      end

      private
      attr_reader :input, :output, :random, :game, :asker, :board_type, :who_will_play, :play_again

      def reset_game
        board_size = board_type.read
        players = who_will_play.read
        @game = Game.new(board_size, players[0], players[1], random)
        game.register_human_factory(lambda{|mark| Players::Human.new(mark, input, output)})
      end

      def print_board
        output.puts BoardFormatter.new.format(game.marks)
      end

      def make_move
        game.tick
      end

      def is_game_finished?
        game.is_finished?
      end

      def print_result
        output.puts(announcement_of(game.winner))if game.is_finished?
      end

      def announcement_of(winner)
        winner.nil?? "It is a draw." : "Player #{winner.to_s.upcase} has won!"
      end

      def play_again?
        play_again.get
      end
    end
  end
end
