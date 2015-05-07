module TicTacToe
  module Ui
    class ConsoleUi
      ENTER_MOVE_PROMPT = "Please enter your next move: "
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
    end
  end
end
