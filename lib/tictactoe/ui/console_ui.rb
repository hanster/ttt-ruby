module TicTacToe
  module Ui
    class ConsoleUi
      ENTER_MOVE_PROMPT = "Please enter your next move: "
      CANNOT_MAKE_MOVE_PROMPT = "Cannot make that move, try again."
      def initialize(input, output)
        @input = input
        @output = output
      end

      def display_message(message)
        @output.puts message
      end

      def prompt_move_input
        display_message(ENTER_MOVE_PROMPT)
        value = @input.gets
        value[/^[0-8]$/] && value.to_i
      end

      def prompt_for_move(board)
        move = prompt_move_input
        return move if valid_move?(board, move)
        display_message(CANNOT_MAKE_MOVE_PROMPT)
        self.prompt_for_move(board)
      end

      private

      def valid_move?(board, move)
        board.available_moves.include?(move)
      end
    end
  end
end
