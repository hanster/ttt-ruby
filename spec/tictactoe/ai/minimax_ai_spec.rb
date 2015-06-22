require 'spec_helper'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/board'
require 'tictactoe/board_helper'

module TicTacToe
  module Ai
    describe MinimaxAi do
      let(:minimax) { MinimaxAi.new }
      let(:x_marker) { MinimaxAi::X_MARKER }
      let(:o_marker) { MinimaxAi::O_MARKER }

      def initial_board(layout)
        BoardHelper.create_initial_board_three(layout)
      end

      it "returns the only possible move if there is one move left" do
        board = initial_board('XOXOOX-XO')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "returns the winning move from 2 possible moves for the O marker" do
        board = initial_board('XOXXOO--X')
        expect(minimax.calculate_next_move(board, o_marker)).to eq(7)
      end

      it "returns the winning move from 2 possible moves for the X marker" do
        board = initial_board('XOXXOO--X')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "return blocking move when no win is available" do
        board = initial_board('XOXO-O-X-')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(4)
      end

      it "return blocking move when no win is available for O marker" do
        board = initial_board('OXOX-X-O-')
        expect(minimax.calculate_next_move(board, o_marker)).to eq(4)
      end

      it "profile board four perfermance test" do
        board = BoardHelper.create_initial_board_four('X-O--X---O-X----')
        expect(minimax.calculate_next_move(board, o_marker)).to eq (1)
      end

      it "board four perfermance test for first ai move" do
        board = BoardHelper.create_initial_board_four('X-O--X---OX-----')
        expect(minimax.calculate_next_move(board, o_marker)).to eq (15)
      end

      it "blocks the X from winning" do
        board = BoardHelper.create_initial_board_four('OOXXOOX---X----X')
        expect(minimax.calculate_next_move(board, o_marker)).to eq(14)
      end
    end
  end
end
