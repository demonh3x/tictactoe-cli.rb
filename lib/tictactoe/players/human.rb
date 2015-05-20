module Tictactoe
  module Players
    class Human
      attr_reader :mark

      def initialize(mark, input, output)
        @mark = mark
        @input = input
        @output = output
      end

      def get_move(state)
        print_turn
        read_valid_move(state)
      end

      private
      attr_reader :input, :output

      def print_turn
        output.puts("Your turn! Where do you want to move?")
      end

      def read_valid_move(state)
        begin
          move = read_move
          available = available?(move, state)
          print_not_available() if !available
        end until available

        move
      end

      def available?(move, state)
        state.available_moves.include?(move)
      end

      def read_move
        begin
          input_string = read_input
          move = parse_move(input_string)
          invalid_input = move.nil?
          print_invalid_input(input_string) if invalid_input
        end while invalid_input

        move
      end

      def read_input
        str = input.gets
        raise "No data read from the CLI input!" if str.nil?
        str.chomp
      end

      def parse_move(move_string)
        Integer(move_string) rescue nil
      end

      def print_invalid_input(input_string)
        output.puts "Don't understand \"#{input_string}\". Please, make sure you use a number."
      end

      def print_not_available
        output.puts "That move is not available. Please, try another one.\n"
      end
    end
  end
end
