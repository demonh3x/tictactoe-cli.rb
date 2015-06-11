require 'tictactoe'
require 'tictactoe/cli/options/cli_asker'
require 'tictactoe/cli/options/play_again_option'
require 'tictactoe/cli/options/board_type_selection'
require 'tictactoe/cli/options/players_selection'
require 'tictactoe/cli/board_formatter'
require 'tictactoe/players/factory'
require 'tictactoe/players/perfect_computer'
require 'tictactoe/players/human'

module Tictactoe
  module Cli
    class Runner
      def initialize(input=$stdin, output=$stdout, random=Random.new)
        self.output = output

        self.players_factory = self.class.create_players_factory(input, output, random)

        self.asker = Options::CliAsker.new(input, output)
        self.board_type = Options::BoardTypeSelection.new(asker)
        self.who_will_play = Options::PlayersSelection.new(asker)
        self.play_again = Options::PlayAgainOption.new(asker)
      end

      def run
        begin
          reset_game

          print_board
          begin
            make_move
            print_board
          end until game_finished?

          print_result
        end while play_again?
      end

      private
      attr_accessor :output, :players_factory, :game, :asker, :board_type, :who_will_play, :play_again

      def self.create_players_factory(input, output, random)
        factory = Tictactoe::Players::Factory.new
        factory.register(:computer, lambda { |mark| Tictactoe::Players::PerfectComputer.new(mark, random) })
        factory.register(:human, lambda { |mark| Players::Human.new(mark, input, output) })
        factory
      end

      def reset_game
        board_size = board_type.read
        players = who_will_play.read
        self.game = Game.new(players_factory, board_size, players[0], players[1])
      end

      def print_board
        output.puts BoardFormatter.new.format(game.marks)
      end

      def make_move
        game.tick
      end

      def game_finished?
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
