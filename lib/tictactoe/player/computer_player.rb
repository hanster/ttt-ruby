module TicTacToe
  module Player
    class ComputerPlayer
      attr_reader :marker
      def initialize(ai = RandomAi.new, marker)
        @ai = ai
        @marker = marker
      end

      def next_move(board)
        @ai.calculate_next_move(board, @marker)
      end
    end

    class RandomAi
      def calculate_next_move(board, marker)
        board.available_moves.sample
      end
    end
  end
end
