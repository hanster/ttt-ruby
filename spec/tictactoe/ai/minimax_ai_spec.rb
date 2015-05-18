require 'spec_helper'
require 'tictactoe/ai/minimax_ai'

module TicTacToe
  module Ai
    describe MinimaxAi do
      let(:minimax) { MinimaxAi.new }
      let(:x_marker) { MinimaxAi::X_MARKER }
      let(:o_marker) { MinimaxAi::O_MARKER }

      it "returns the only possible move if there is one move left" do
        board = Board.new('XOXOOX-XO')

        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "returns the winning move from 2 possible moves for the O marker" do
        board = Board.new('XOXXOO--X')

        expect(minimax.calculate_next_move(board, o_marker)).to eq(7)
      end

      it "returns the winning move from 2 possible moves for the X marker" do
        board = Board.new('XOXXOO--X')

        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "return blocking move when no win is available" do
        board = Board.new('XOXO-O-X-')

        expect(minimax.calculate_next_move(board, x_marker)).to eq(4)
      end

      it "return blocking move when no win is available for O marker" do
        board = Board.new('OXOX-X-O-')

        expect(minimax.calculate_next_move(board, o_marker)).to eq(4)
      end

      it "scores 0 when the move will result in a draw" do
        board = Board.new('XOXOOX-XO')
        minimax = MinimaxAi.new
        marker = x_marker

        move = 6
        expect(minimax.score(board, x_marker, move)).to eq(0)
      end

      it "scores 100 when the move will result in a win for X" do
        board = Board.new('XOXOXOOX-')
        move = 8

        expect(minimax.score(board, x_marker, move)).to eq(100)
      end

      it "scores 100 when the move will result in a win for O" do
        board = Board.new('OXOOX----')
        move = 6

        expect(minimax.score(board, o_marker, move)).to eq(100)
      end

      
    end
  end
end
