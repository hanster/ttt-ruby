module TicTacToe
  module Ui
    class ConsoleUi
      ENTER_MOVE_PROMPT = "Player %s, Please enter your next move: "
      CANNOT_MAKE_MOVE_PROMPT = "Cannot make that move, try again."
      BOARD_TEMPLATE = 
        "  %s  |  %s  |  %s  \n" +
        "-----+-----+-----\n" +
        "  %s  |  %s  |  %s  \n" +
        "-----+-----+-----\n" +
        "  %s  |  %s  |  %s  \n\n"
      ANSI_CLS = "\u001b[2J"
      ANSI_HOME = "\u001b[H"

      def initialize(input = STDIN, output = STDOUT)
        @input = input
        @output = output
      end

      def display_message(message)
        @output.puts message
      end

      def prompt_move_input(marker)
        display_message(ENTER_MOVE_PROMPT % marker)
        value = @input.gets
        value[/^[0-8]$/] && value.to_i
      end

      def prompt_for_move(board, marker)
        move = prompt_move_input(marker)
        return move if valid_move?(board, move)
        display_message(CANNOT_MAKE_MOVE_PROMPT)
        self.prompt_for_move(board, marker)
      end

      def draw_board(board)
        display_message(BOARD_TEMPLATE % board.positions_representation)
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      private

      def valid_move?(board, move)
        board.available_moves.include?(move)
      end
    end
  end
end
