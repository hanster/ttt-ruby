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

      def calculate_next_move(board, marker)
        # check 1 move deep for a winning or blocking move
        # prefer this to a depth first search to improve speed
        calculate_winning_or_blocking_move(board, marker)
        return winning_or_blocking_next_move if winning_or_blocking_next_move?
        calculate_next_best_move(board, marker)
      end

      private

      attr_reader :blocking_move, :winning_move

      def calculate_next_move_score(board, marker, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA, depth = 7)
        best_move = {:move => :NO_BEST_MOVE, :score => MINIMAX_STARTING_VALUE }

        board.available_moves.each do |move|
          move_score = score(board, marker, move, alpha, beta, depth)
          if move_score > best_move[:score]
            best_move[:move] = move
            best_move[:score] = move_score
          end
          alpha = [alpha, move_score].max
          break if alpha >= beta
        end

        return best_move
      end

      def winning_or_blocking_next_move
        return winning_move if winning_move
        return blocking_move if blocking_move
      end

      def winning_or_blocking_next_move?
        winning_move || blocking_move
      end

      def calculate_winning_or_blocking_move(board, marker)
        @winning_move = next_winning_move(board, marker)
        @blocking_move = block_next_winning_move(board, marker)
      end

      def calculate_next_best_move(board, marker)
        best_move = calculate_next_move_score(board, marker)
        best_move[:move]
      end

      def block_next_winning_move(board, marker)
        opponent = opponent(marker)
        next_winning_move(board, opponent)
      end

      def next_winning_move(board, marker)
        board.available_moves.find do |move|
          next_board = board.move(move, marker)
          next_board.won?(marker)
        end
      end

      def score(board, marker, move, alpha = DEFAULT_ALPHA, beta = DEFAULT_BETA, depth)
        next_board = board.move(move, marker)
        return MINIMAX_MAX_VALUE if next_board.won?(marker)
        return MINIMAX_DRAW_VALUE if next_board.draw?
        return 0 if depth == 0

        next_marker = opponent(marker)
        next_move = calculate_next_move_score(next_board, next_marker, -beta, -alpha, depth - 1)
        return -adjust_for_depth(next_move[:score])
      end

      def adjust_for_depth(score)
        if score > 0
          score - 1
        elsif score < 0
          score + 1
        else
          score
        end
      end
    end
  end
end
