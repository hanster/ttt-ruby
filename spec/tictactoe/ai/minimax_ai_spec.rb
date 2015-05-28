require 'spec_helper'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/board'
require 'tictactoe/board_four'

module TicTacToe
  module Ai
    describe MinimaxAi do
      let(:minimax) { MinimaxAi.new }
      let(:x_marker) { MinimaxAi::X_MARKER }
      let(:o_marker) { MinimaxAi::O_MARKER }

      it "returns the only possible move if there is one move left" do
        board = Board.initial_board('XOXOOX-XO')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "returns the winning move from 2 possible moves for the O marker" do
        board = Board.initial_board('XOXXOO--X')
        expect(minimax.calculate_next_move(board, o_marker)).to eq(7)
      end

      it "returns the winning move from 2 possible moves for the X marker" do
        board = Board.initial_board('XOXXOO--X')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(6)
      end

      it "return blocking move when no win is available" do
        board = Board.initial_board('XOXO-O-X-')
        expect(minimax.calculate_next_move(board, x_marker)).to eq(4)
      end

      it "return blocking move when no win is available for O marker" do
        board = Board.initial_board('OXOX-X-O-')
        expect(minimax.calculate_next_move(board, o_marker)).to eq(4)
      end

      xit "board four perfermance test" do
        require 'ruby-prof'

        RubyProf.start
        
        board = BoardFour.initial_board('XO--XO--X-------')
        expect(minimax.calculate_next_move(board, o_marker)).to eq (12) 

        result = RubyProf.stop
        printer = RubyProf::GraphHtmlPrinter.new(result)
        printer.print(STDOUT)
      end
    end
  end
end
