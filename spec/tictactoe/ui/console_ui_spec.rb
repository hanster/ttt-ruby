require 'spec_helper'
require 'tictactoe/ui/console_ui'
require 'tictactoe/marker'

module TicTacToe
  module Ui
    describe ConsoleUi do
      let(:output) { StringIO.new }
      let(:marker) { Marker::X_MARKER }
                 
      it "displays a given message to console" do
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.display_message("test message")
        expect(output.string).to start_with("test message")
      end

      it "takes in user input, which represents a move" do
        input = StringIO.new("0\n")
        ui = ConsoleUi.new(input, output)
        user_input = ui.prompt_move_input(marker)
        expect(user_input).to eq(0)
      end

      it "returns false when an move input is not 0-8" do
        input = StringIO.new("a\n")
        ui = ConsoleUi.new(input, output)
        expect(ui.prompt_move_input(marker)).to be nil
      end

      it "asks the user to enter a move" do
        input = StringIO.new("0\n")
        ui = ConsoleUi.new(input, output)
        ui.prompt_move_input(marker)
        expect(output.string).to start_with("Player #{marker}, Please enter your next move: ")
      end

      it "keeps asking for the user to enter a move until it chooses a valid move" do
        input = StringIO.new("a\n1\n8\n")
        ui = ConsoleUi.new(input, output)
        board = Board.new('XXXXXX---')
        expect(ui.prompt_for_move(board, marker)).to eq(8)
        expect(output.string).to include("Cannot make that move, try again.")
      end

      it "draws the board" do
        board = Board.new
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.draw_board(board)
        expect(output.string).to include("  0  |  1  |  2  \n" +
                                        "-----+-----+-----\n" +
                                        "  3  |  4  |  5  \n" +
                                        "-----+-----+-----\n" +
                                        "  6  |  7  |  8  \n")
      end

      it "clears the screen" do
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.clear_screen
        expect(output.string).to include("\u001b[2J" + "\u001b[H")
       end
    end
  end
end
