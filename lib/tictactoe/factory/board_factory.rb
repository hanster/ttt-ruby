require 'tictactoe/board'
require 'tictactoe/game_types'

module TicTacToe
  module Factory
    class BoardFactory
      include GameTypes

      def create(board_type)
        case board_type
        when TWO_BOARD
          return Board.make_board(2)
        when THREE_BOARD
          return Board.make_board(3)
        when FOUR_BOARD
          return Board.make_board(4)
        else
          return Board.make_board(3)
        end
      end

      def create_from_string(board_type_string)
        board_type_code = BOARD_OPTIONS.key(board_type_string)
        create(board_type_code)
      end
    end
  end
end
