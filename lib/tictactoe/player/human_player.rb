module TicTacToe
  module Player
    class HumanPlayer
      attr_accessor :marker

      def initialize(ui, marker)
        @ui = ui
        @marker = marker
      end

      def next_move(board)
        @ui.prompt_for_move(board, @marker)
      end
    end
  end
end
