require 'spec_helper'
require 'tictactoe/players/human'

RSpec.describe Tictactoe::Players::Human do
  let(:input){StringIO.new}
  let(:output){StringIO.new}

  def user_will_send(str)
    input.string += "#{str}\n"
  end

  def create(mark = :x)
    described_class.new(mark, input, output)
  end

  def state(available_moves = (0..8).to_a)
    spy(:available_moves => available_moves)
  end

  it 'has the mark' do
    expect(create(:x).mark).to eq(:x)
    expect(create(:o).mark).to eq(:o)
  end

  describe "when asking for a move" do
    it "prints the message doing it" do
      user_will_send("1")
      create.get_move(state)
      expect(output.string).to include("Your turn! Where do you want to move?\n")
    end

    describe "given no input" do
      it "raises an error" do
        expect{create.get_move(state)}.to raise_error("No data read from the CLI input!")
      end
    end

    describe "given an input with no whitespaces" do
      it "reads the move" do
        user_will_send("7")
        expect(create.get_move(state)).to eq(7)
      end
    end

    describe "given an input with some whitespaces" do
      it "reads the move" do
        user_will_send("  \t 2 \t ")
        expect(create.get_move(state)).to eq(2)
      end
    end

    describe "given an invalid input" do
      it "should try to read again" do
        invalid_input = "::invalid_input::"
        user_will_send(invalid_input)
        user_will_send("4")
        expect(create.get_move(state)).to eq(4)
        expect(output.string).to include("Don't understand \"#{invalid_input}\". Please, make sure you use a number.\n")
      end
    end

    describe "given only one available move" do
      it "should try again if not selected" do
        user_will_send("0")
        user_will_send("4")
        expect(create.get_move(state([4]))).to eq(4)
        expect(output.string).to include("That move is not available. Please, try another one.\n")
      end
    end
  end
end
