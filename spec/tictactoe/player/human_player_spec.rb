require 'spec_helper'
require 'tictactoe/player/human_player'
require 'tictactoe/board'
require 'tictactoe/marker'

module TicTacToe
  module Player
    include Marker

    describe HumanPlayer do
      let(:board) { Board.make_board(3) }
      let(:ui) { MockUi.new }
      let(:player) { HumanPlayer.new(ui, X_MARKER) }
      it "takes in a UI class and the players marker (X, or O) on initialization" do
        ui = ui
      end

      it "has a set marker after initialization" do
        expect(player.marker).to eq(X_MARKER)
      end

      it "makes attempts to make a move by asking for input" do
        expect(player.next_move(board)).to be_between(0,8).inclusive
      end
    end
  end

  class MockUi
    def prompt_for_move(board, marker)
      board.available_moves.sample
    end
  end
end
