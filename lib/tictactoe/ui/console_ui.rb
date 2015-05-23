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

      def prompt_for_move(board, marker)
        loop do
          move = prompt_move_input(marker)
          return move if valid_move?(board, move)
          display_message(CANNOT_MAKE_MOVE_PROMPT)
        end
      end

      def prompt_move_input(marker)
        display_message(ENTER_MOVE_PROMPT % marker)
        convert_input_to_move(@input.gets)
      end

      def valid_move?(board, move)
        move && board.move_available?(move)
      end

      def convert_input_to_move(value)
        value = value[/^([1-9]|1[0-6])$/] && value.to_i
        value - INDEX_OFFSET if value
      end

      def draw_board(board)
        board_positions = offset_indices(board.positions_representation)
        display_message(board.get_template % board_positions)
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      # outside loop not recursion
      # #same level of abstraction
      def prompt_game_type(options)
        loop do
          input_value = prompt_game_type_input(options)
          value = convert_input_to_game_type(input_value)
          return value if valid_game_type?(value)
          display_message(INVALID_GAME_TYPE_PROMPT)
        end
      end

      def prompt_game_type_input(options)
          #one level
          display_message(options)
          display_message(ENTER_GAME_TYPE_PROMPT)
          #another level
          @input.gets
      end

      def convert_input_to_game_type(value)
        value[/^[1-4]$/] && value.to_i
      end

      def valid_game_type?(game_type_input)
          game_type_input
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

      def offset_indices(board_positions)
        board_positions.map do |position|
          position.is_a?(Integer) ? position + INDEX_OFFSET : position
        end
      end

      # interact with board 
    end
  end
end
