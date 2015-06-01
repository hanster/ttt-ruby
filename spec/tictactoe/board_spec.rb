require 'spec_helper'
require 'tictactoe/board'
require 'tictactoe/board_helper'

module TicTacToe
  describe Board do
    let(:x_marker) { Marker::X_MARKER }

    def initial_board(layout)
      BoardHelper.create_initial_board_three(layout)
    end

    it "starts with an empty board" do
      board = Board.new()
      expect(board.string_positions).to eq('---------')
    end

    it "makes a move" do
      board = Board.new().move(0, x_marker)
      expect(board.string_positions).to eq('X--------')
    end

    it "changes turn after a move" do
      board = Board.new().move(0, x_marker).move(1, Marker::O_MARKER)
      expect(board.string_positions).to eq('XO-------')
    end

    it "after making a move, that move is no longer available" do
      board = Board.new().move(0, x_marker)
      expect(board.move_available?(0)).to be false
    end

    it "keeps switching turns" do
      board = Board.new().move(0, x_marker).move(1, Marker::O_MARKER).move(2, x_marker)
      expect(board.string_positions).to eq('XOX------')
    end

    it "returns the 0 available positions" do
      board = initial_board('XXXXXXXXX')
      expect(board.available_moves).to eq([])
    end

    it 'returns the markers at positions' do
       board = initial_board('XXXOOO---')
       expect(board.marker_at_position(0)).to eq(Marker::X_MARKER)
       expect(board.marker_at_position(3)).to eq(Marker::O_MARKER)
       expect(board.marker_at_position(6)).to eq(Marker::EMPTY_MARKER)
    end

    it "returns the all available positions" do
      board = Board.new()
      expect(board.available_moves).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    end

    describe "#game_over?" do
      it "isn't game over when there is a new board" do
        board = Board.new()
        expect(board.game_over?).to be false
      end

      it "is game over when there are no more moves left" do
        board = initial_board('XXXXXXXXX')
        expect(board.game_over?).to be true
      end

      it "is game over when a player has won" do
        board = initial_board('XXX-OO---')
        expect(board.game_over?).to be true
      end
    end

    describe "#has_won?" do
      context "not won" do
        it "No wins yet" do
          board = Board.new
          expect(board.has_won?('X')).to be false
          expect(board.has_won?('O')).to be false
          board = initial_board('OXXXXOOOX')
          expect(board.has_won?('X')).to be false
          expect(board.has_won?('O')).to be false
        end
      end
      context "player has won" do
        it "vertical cases" do
          board = initial_board('XO-XX-X--')
          expect(board.has_won?('X')).to be true
          board = initial_board('-X--X--X-')
          expect(board.has_won?('X')).to be true
          board = initial_board('--X--X--X')
          expect(board.has_won?('X')).to be true
        end

        it "horizontal cases" do
          board = initial_board('OOO------')
          expect(board.has_won?('O')).to be true
          board = initial_board('---OOO---')
          expect(board.has_won?('O')).to be true
          board = initial_board('------OOO')
          expect(board.has_won?('O')).to be true
        end

        it "diagonal cases" do 
          board = initial_board('X---X---X')
          expect(board.has_won?('X')).to be true
          board = initial_board('--O-O-O--')
          expect(board.has_won?('O')).to be true
        end
      end
    end

    it "return array of the positions, either the index or if it is X or O" do
      board = initial_board('---XXXXXX')
      expect(board.positions_representation).to eq([0, 1, 2, 'X', 'X', 'X', 'X', 'X', 'X'])
    end

    describe "#game_over_message#" do
      it "returns X wins message" do
        board = initial_board('XXX------')
        expect(board.game_over_message).to eq("Game Over\n\n#{x_marker} wins!")
      end

      it "returns draw message" do
        board = initial_board('XOXOOXXXO')
        expect(board.game_over_message).to eq("Game Over\n\nIt's a draw!")
      end

      it "returns O wins message" do
        board = initial_board('OOO------')
        expect(board.game_over_message).to eq("Game Over\n\n#{Marker::O_MARKER} wins!")
      end

      it "returns true when the board has no winner and no moves" do
        board = initial_board('XOXOOXXXO')
        expect(board.draw?).to be true
      end
    end

    it 'works out the horizontal win cases' do
      board = Board.new(3)
      expect(board.horizontal_wins).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    end

    it 'works out the horizontal win cases for a 4 board' do
      board = Board.new(4)
      expect(board.horizontal_wins).to eq([[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]])
    end

    it 'works out the vertical win cases for a 3 board' do
      board = Board.new(3)
      expect(board.vertical_wins).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end

    it 'works out the vertical win cases for a 4 board' do
      board = Board.new(4)
      expect(board.vertical_wins).to eq([[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]])
    end

    it 'works out the diagonal win for a 3 board' do
      board = Board.new(3)
      expect(board.diagonal_wins).to eq([[0, 4, 8], [2, 4, 6]])
    end
    
    it 'works out the diagonal win for a 4 board' do
      board = Board.new(4)
      expect(board.diagonal_wins).to eq([[0, 5, 10, 15], [3, 6, 9, 12]])
    end

    it "returns all available positions" do
      board = Board.new(4)
      expect(board.available_moves).to eq((0..15).to_a)
    end

    it "wins horizontal" do
      board = BoardHelper.create_initial_board_four('-----------XXXXX')
      expect(board.has_won?(x_marker)).to be true
    end

    it "is not a win with 3 in a row" do
      board = Board.new(4).move(0, x_marker).move(1, x_marker).move(2, x_marker)
      expect(board.has_won?(x_marker)).to be false
    end

    it "makes a valid move" do
      board = Board.new(4).move(14, x_marker)
      expect(board.move_available?(14)).to be false
    end
  end
end
