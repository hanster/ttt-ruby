require 'tictactoe/board'

module TicTacToe
  module Factory
    class BoardFactory
      TWO_BOARD = 1
      THREE_BOARD = 2
      FOUR_BOARD = 3

      BOARD_OPTIONS = {
        1 => '2x2',
        2 => '3x3',
        3 => '4x4'
      }

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

      def create_from_string(board_type_string)
        board_type_code = BOARD_OPTIONS.key(board_type_string)
        create(board_type_code)
      end
    end
  end
end
