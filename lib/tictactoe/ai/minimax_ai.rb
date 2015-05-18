require 'tictactoe/marker'

module TicTacToe
  module Ai
    class MinimaxAi
    include Marker
      def calculate_next_move(board, marker)
        minimax_value = -101
        best_move = :NO_BEST_MOVE

        board.available_moves.each do |move|
          move_score = score(board, marker, move) 
          if move_score > minimax_value
            minimax_value = move_score
            best_move = move
          end
        end

        return best_move
      end

      def score(board, marker, move)
        next_board = board.move(move, marker)
        return 0 if next_board.is_draw?
        return 100 if next_board.has_won?(marker)

        next_marker = opponent(marker)
        next_move = calculate_next_move(next_board, next_marker)
        return score(next_board, next_marker, next_move) * -1
      end
    end
  end
end
