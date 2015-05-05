require 'spec_helper'
require 'tictactoe/board'

module TicTacToe
  describe Board do
    it "starts with an empty board" do
      board = Board.new()
      expect(board.to_s).to eq('-' * Board::BOARD_SIZE)
    end

    it "makes a move" do
      board = Board.new().move(0)
      expect(board.to_s).to eq('X--------')
    end

    it "changes turn after a move" do
      board = Board.new().move(0).move(1)
      expect(board.to_s).to eq('XO-------')
    end

    it "keeps switching turns" do
      board = Board.new().move(0).move(1).move(2)
      expect(board.to_s).to eq('XOX------')
    end

    it "returns the 0 available positions" do
      board = Board.new('XXXXXXXXX')
      expect(board.available_positions).to eq([])
    end

    it "returns the all available positions" do
      board = Board.new()
      expect(board.available_positions).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    end
  end
end
