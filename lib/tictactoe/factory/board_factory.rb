require 'tictactoe/board'

module TicTacToe
  module Factory
    class BoardFactory
      TWO_BOARD = 1
      THREE_BOARD = 2
      FOUR_BOARD = 3

      def create(board_type)
        case board_type
        when TWO_BOARD
          return Board.new(2)
        when THREE_BOARD
          return Board.new(3)
        when FOUR_BOARD
          return Board.new(4)
        else
          return Board.new
        end
      end
    end
  end
end
