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

    describe "#game_over?" do
      it "isn't game over when there is a new board" do
        board = Board.new()
        expect(board.game_over?).to be false
      end

      it "is game over when there are no more moves left" do
        board = Board.new('XXXXXXXXX')
        expect(board.game_over?).to be true
      end

      it "is game over when a player has won" do
        board = Board.new('XXX-OO---')
        expect(board.game_over?).to be true
      end
    end

    describe "#has_won?" do
      context "not won" do
        it "No wins yet" do
          board = Board.new
          expect(board.has_won?('X')).to be false
          expect(board.has_won?('O')).to be false
          board = Board.new('OXXXXOOOX')
          expect(board.has_won?('X')).to be false
          expect(board.has_won?('O')).to be false
        end
      end
      context "player has won" do
        it "vertical cases" do
          board = Board.new('XO-XX-X--')
          expect(board.has_won?('X')).to be true
          board = Board.new('-X--X--X-')
          expect(board.has_won?('X')).to be true
          board = Board.new('--X--X--X')
          expect(board.has_won?('X')).to be true
        end

        it "horizontal cases" do
          board = Board.new('OOO------')
          expect(board.has_won?('O')).to be true
          board = Board.new('---OOO---')
          expect(board.has_won?('O')).to be true
          board = Board.new('------OOO')
          expect(board.has_won?('O')).to be true
        end

        it "diagonal cases" do 
          board = Board.new('X---X---X')
          expect(board.has_won?('X')).to be true
          board = Board.new('--O-O-O--')
          expect(board.has_won?('O')).to be true
        end
      end
    end
  end
end
