module TicTacToe
  module Ui
    class ConsoleUi
      ENTER_MOVE_PROMPT = "Player %s, Please enter your next move: "
      CANNOT_MAKE_MOVE_PROMPT = "Cannot make that move, try again."
      ENTER_GAME_TYPE_PROMPT = "Enter the game type: "
      INVALID_GAME_TYPE_PROMPT = "Invalid game type."
      PLAY_AGAIN_PROMPT = "Do you want to play again?"
      INVALID_PLAY_AGAIN_PROMPT = "Invalid input (y/n)"
      GOODBYE_MESSAGE = "Goodbye and Thanks for playing!"
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
      INDEX_OFFSET = 1

      # SRP - validation
      # prompt for new game
      # prompt for game types
      # prompt for moves and the displaying of the board

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
        value[/^[1-9]$/] && value.to_i
      end

      def prompt_for_move(board, marker)
        move = prompt_move_input(marker)
        move = move - INDEX_OFFSET if move
        return move if valid_move?(board, move)
        display_message(CANNOT_MAKE_MOVE_PROMPT)
        self.prompt_for_move(board, marker)
      end

      def draw_board(board)
        board_positions = offset_indices(board.positions_representation)
        display_message(BOARD_TEMPLATE % board_positions)
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      # outside loop not recursion
      # #same level of abstraction
      def prompt_game_type(options)
        #one level
        display_message(options)
        display_message(ENTER_GAME_TYPE_PROMPT)
        #another level
        value = @input.gets
        value = value[/^[1-4]$/] && value.to_i
        return value if value
        #
        display_message(INVALID_GAME_TYPE_PROMPT)
        self.prompt_game_type(options)
      end

      #returns in the middle are a smell
      def prompt_play_again?
        display_message(PLAY_AGAIN_PROMPT)
        value = @input.gets.chomp
        if value == YES_INPUT|| value == NO_INPUT
          value == YES_INPUT
        else
          display_message(INVALID_PLAY_AGAIN_PROMPT)
          self.prompt_play_again?
        end
      end

      def prompt_good_bye
        display_message(GOODBYE_MESSAGE)
      end

      private

      def valid_move?(board, move)
        board.available_moves.include?(move)
      end

      def offset_indices(board_positions)
        board_positions.map do |position|
          position.is_a?(Integer) ? position + INDEX_OFFSET : position
        end
      end

      # interact with board 
    end
  end
end
