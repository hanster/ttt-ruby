module TicTacToe
  module Ui
    class ConsoleUi
      ENTER_MOVE_PROMPT = "Player %s, Please enter your next move: "
      CANNOT_MAKE_MOVE_PROMPT = "Cannot make that move, try again."
      ENTER_GAME_TYPE_PROMPT = "Enter the game type: "
      INVALID_GAME_TYPE_PROMPT = "Invalid game type."
      PLAY_AGAIN_PROMPT = "Do you want to play again?"
      INVALID_PLAY_AGAIN_PROMPT = "Invalid input (y/n)"
      YES_INPUT = 'y'
      NO_INPUT = 'n'
      BOARD_TEMPLATE = 
        "\n" +
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

      def prompt_game_type
        display_message(ENTER_GAME_TYPE_PROMPT)
        value = @input.gets
        value = value[/^[1-4]$/] && value.to_i
        return value if value
        display_message(INVALID_GAME_TYPE_PROMPT)
        self.prompt_game_type
      end

      def prompt_play_again?
        display_message(PLAY_AGAIN_PROMPT)
        value = @input.gets.chomp
        if value == YES_INPUT|| value == NO_INPUT
          return true if value == YES_INPUT
          return false
        end
        display_message(INVALID_PLAY_AGAIN_PROMPT)
        self.prompt_play_again?
      end

      private

      def valid_move?(board, move)
        board.available_moves.include?(move)
      end
    end
  end
end
