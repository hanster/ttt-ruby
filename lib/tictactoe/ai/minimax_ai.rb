require 'tictactoe/marker'

module TicTacToe
  module Ai
    class MinimaxAi
      include Marker
      MINIMAX_STARTING_VALUE = -101
      MINIMAX_MAX_VALUE = 100
      MINIMAX_DRAW_VALUE = 0
      DEFAULT_ALPHA = -100
      DEFAULT_BETA = 100

      def calculate_next_move(board, marker, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA, depth = 6)
        minimax_value = MINIMAX_STARTING_VALUE
        best_move = :NO_BEST_MOVE

        board.available_moves.each do |move|
          move_score = score(board, marker, move, alpha, beta, depth)
          if move_score > minimax_value
            minimax_value = move_score
            best_move = move
          end
          alpha = [alpha, move_score].max
          break if alpha >= beta
        end

        return best_move
      end

      #don't test this as it locks in the implementation
      def score(board, marker, move, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA, depth)
        next_board = board.move(move, marker)
        return MINIMAX_MAX_VALUE if next_board.won?(marker)
        return MINIMAX_DRAW_VALUE if next_board.draw?
        return 0 if depth == -1

        next_marker = opponent(marker)
        next_move = calculate_next_move(next_board, next_marker, -beta, -alpha, depth - 1)
        return -score(next_board, next_marker, next_move, alpha, beta, depth - 1)
      end
    end
  end
end
