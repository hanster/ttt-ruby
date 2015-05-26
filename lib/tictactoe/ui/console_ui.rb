require 'tictactoe/ui/input_move'
require 'tictactoe/ui/input_board'
require 'tictactoe/ui/input_new_game'
require 'tictactoe/ui/input_game_type'

module TicTacToe
  module Ui
    class ConsoleUi
      GOODBYE_MESSAGE = "Goodbye and Thanks for playing!"
      ANSI_CLS = "\u001b[2J"
      ANSI_HOME = "\u001b[H"
      INDEX_OFFSET = 1

      # SRP - validation
      # prompt for new game
      # prompt for game types
      # prompt for moves and the displaying of the board
      # prompt for board type

      def initialize(input = STDIN, output = STDOUT)
        @input = input
        @output = output
      end

      def display_message(message)
        @output.puts message
      end

      def prompt_for_move(board, marker)
        input_move = InputMove.new(@input, marker)
        loop do
          display_message(input_move.prompt_message)
          input_move.parse_input
          return input_move.value if input_move.valid?(board)
          display_message(input_move.invalid_message)
        end
      end

      def draw_board(board)
        board_positions = offset_indices(board.positions_representation)
        display_message(board.get_template % board_positions)
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      def prompt_board_type(options)
        input_board = InputBoard.new(@input)
        loop do
          display_message(options)
          display_message(input_board.prompt_message)
          input_board.parse_input
          return input_board.value if input_board.valid?
          display_message(input_board.invalid_message)
        end
      end

      def prompt_game_type(options)
        input_game_type = InputGameType.new(@input)
        loop do
          display_message(options)
          display_message(input_game_type.prompt_message)
          input_game_type.parse_input
          return input_game_type.value if input_game_type.valid?
          display_message(input_game_type.invalid_message)
        end
      end

      #returns in the middle are a smell
      def prompt_play_again?
        input_new_game = InputNewGame.new(@input)
        loop do
          display_message(input_new_game.prompt_message)
          input_new_game.parse_input
          return input_new_game.value == InputNewGame::YES_INPUT if input_new_game.valid?
          display_message(input_new_game.invalid_message)
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
