require 'spec_helper'
require 'tictactoe/board'
require 'tictactoe/board_four'

module TicTacToe
  describe BoardFour do
    let(:x_marker) { Marker::X_MARKER }
    it "is a subclass of Board" do
      expect(BoardFour.new.kind_of?(Board)).to be true
    end

    it "returns all available positions" do
      board = BoardFour.new
      expect(board.available_moves).to eq((0..15).to_a)
    end

    it "wins horizontal" do
      board = BoardFour.initial_board('-----------XXXXX')
      expect(board.has_won?(x_marker)).to be true
      expect(board.is_a?(BoardFour)).to be true
    end

    it "is not a win with 3 in a row" do
      board = BoardFour.new.move(0, x_marker).move(1, x_marker).move(2, x_marker)
      expect(board.has_won?(x_marker)).to be false
    end

    it "makes a valid move" do
      board = BoardFour.new.move(14, x_marker)
      expect(board.move_available?(14)).to be false
      expect(board.is_a?(BoardFour)).to be true
    end
  end
end
