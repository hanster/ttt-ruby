module TicTacToe
  module Ui
    class GraphicalUi
      WINNER_MESSAGE = "%s wins!"
      DRAW_MESSAGE = "It's a draw!"
      def add_label(info_label)
        @info_label = info_label
      end
      def prompt_for_move(board, marker)

      end

      def clear_screen

      end

      def draw_board(board)

      end

      def display_end_game_message(end_game_state)
        message = ''
        if end_game_state == Board::DRAW
          message = DRAW_MESSAGE
        else
          message = WINNER_MESSAGE % end_game_state
        end
        @info_label.text = "Game Over\n\n" + message
      end
    end
  end
end
