require 'spec_helper'
require 'tictactoe/ui/console_ui'

module TicTacToe
  module Ui
    describe ConsoleUi do
      let(:output) { StringIO.new }
                 
      it "displays a given message to console" do
        input = StringIO.new
        ui = ConsoleUi.new(input, output)
        ui.display_message("test message")
        expect(output.string).to start_with("test message")
      end

      it "takes in user input, which represents a move" do
        input = StringIO.new("0\n")
        ui = ConsoleUi.new(input, output)
        user_input = ui.prompt_move_input
        expect(user_input).to eq(0)
      end

      it "returns false when an move input is not 0-8" do
        input = StringIO.new("a\n")
        ui = ConsoleUi.new(input, output)
        expect(ui.prompt_move_input).to be nil
      end

      it "asks the user to enter a move" do
        input = StringIO.new("0\n")
        ui = ConsoleUi.new(input, output)
        ui.prompt_move_input
        expect(output.string).to start_with("Please enter your next move: ")
      end
    end
  end
end
