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

      def calculate_next_move(board, marker, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA)
        # any corner move is condsidered the best first move
        # http://blog.ostermiller.org/tic-tac-toe-strategy
        return board.random_corner_move if first_move(board)
        minimax_value = MINIMAX_STARTING_VALUE
        best_move = :NO_BEST_MOVE

        board.available_moves.each do |move|
          move_score = score(board, marker, move, alpha, beta)
          if move_score > minimax_value
            minimax_value = move_score
            best_move = move
          end
          alpha = [alpha, move_score].max
          break if alpha >= beta
        end

        return best_move
      end

      def score(board, marker, move, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA)
        next_board = board.move(move, marker)
        return MINIMAX_MAX_VALUE if next_board.has_won?(marker)
        return MINIMAX_DRAW_VALUE if next_board.draw?

        next_marker = opponent(marker)
        next_move = calculate_next_move(next_board, next_marker, -beta, -alpha)
        return -score(next_board, next_marker, next_move, alpha, beta)
      end

      private

      def first_move(board)
        board.available_moves.count == 9
      end
    end
  end
end
