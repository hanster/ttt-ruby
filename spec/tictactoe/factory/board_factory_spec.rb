require 'spec_helper'
require 'tictactoe/factory/board_factory'


module TicTacToe
  module Factory
    describe BoardFactory do
      let(:board_factory) { BoardFactory.new }

      it 'creates a new board' do
        board = board_factory.create(0)
        expect(board.is_a?(Board)).to be true
      end

      it 'creates a new 2 by 2 board' do
        board = board_factory.create(BoardFactory::TWO_BOARD)
        expect(board.dimension).to eq(2)
      end

      it 'creates a new 3 by 3 board' do
        board = board_factory.create(BoardFactory::THREE_BOARD)
        expect(board.dimension).to eq(3)
      end

      it 'creates a new 4 by 4 board' do
        board = board_factory.create(BoardFactory::FOUR_BOARD)
        expect(board.dimension).to eq(4)
      end

    end
  end
end
