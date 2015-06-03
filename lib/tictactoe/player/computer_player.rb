module TicTacToe
  module Player
    class ComputerPlayer
      attr_reader :marker
      def initialize(ai = RandomAi.new, marker)
        @ai = ai
        @marker = marker
      end

      def next_move(board)
        return board.available_moves.sample if first_five_moves_for_four_by_four?(board)
        @ai.calculate_next_move(board, @marker)
      end

      private

      def first_five_moves_for_four_by_four?(board)
        board.available_moves.count > 11 && board.dimension == 4
      end
    end

    class RandomAi
      def calculate_next_move(board, marker)
        board.available_moves.sample
      end
    end
  end
end
