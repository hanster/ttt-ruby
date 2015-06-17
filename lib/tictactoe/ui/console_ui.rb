require 'tictactoe/board'
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
      INDEX_OFFSET = InputMove::INDEX_OFFSET
      CELL_WIDTH = 5
      VERTICAL_SEP = '|'
      HORIZONTAL_SEP = '-'
      CROSS_JOIN = '+'
      WINNER_MESSAGE = "%s wins!"
      DRAW_MESSAGE = "It's a draw!"

      def initialize(input = STDIN, output = STDOUT)
        @input = input
        @output = output
      end

      def display_message(message)
        @output.puts message
      end

      def display_end_game_message(end_game_state)
        if end_game_state == Board::DRAW
          display_message(DRAW_MESSAGE)
        else
          display_message(WINNER_MESSAGE % end_game_state)
        end
      end

      def draw_board(board)
        new_empty_line
        display_message(make_board_representation(board))
        new_empty_line
      end

      def new_empty_line
        @output.puts
      end

      def clear_screen
        @output.print(ANSI_CLS + ANSI_HOME)
      end

      def prompt_good_bye
        display_message(GOODBYE_MESSAGE)
      end

      # how do I extract this duplication?
      def prompt_for_move(board, marker)
        input_move = InputMove.new(@input, marker)
        loop do
          display_message(input_move.prompt_message)
          input_move.parse_input
          return input_move.value if input_move.valid?(board)
          display_message(input_move.invalid_message)
        end
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

      def prompt_play_again?
        input_new_game = InputNewGame.new(@input)
        loop do
          display_message(input_new_game.prompt_message)
          input_new_game.parse_input
          return input_new_game.value == InputNewGame::YES_INPUT if input_new_game.valid?
          display_message(input_new_game.invalid_message)
        end
      end

      private

      def make_board_representation(board)
        board_positions = offset_indices(board)
        center_positions = center_positions(board_positions)
        rows = split_positions_into_rows(center_positions, board.dimension)
        horizon_sep = join_columns(rows)
        join_rows(horizon_sep, board)
      end

      def offset_indices(board)
        board.all_moves.map do |move|
          board.move_available?(move) ? move + INDEX_OFFSET : board.marker_at_position(move)
        end
      end

      def join_rows(rows, board)
        rows.join(row_seperator(board))
      end

      def join_columns(rows)
        rows.map do |row|
          row.join(VERTICAL_SEP)
        end
      end

      def split_positions_into_rows(positions, row_length)
        positions.each_slice(row_length).to_a
      end

      def center_positions(positions)
        positions.map do |position|
          position.to_s.center(CELL_WIDTH)
        end
      end

      def row_seperator(board)
        columns = Array.new(board.dimension, HORIZONTAL_SEP * CELL_WIDTH)
        "\n" + columns.join(CROSS_JOIN) + "\n"
      end
    end
  end
end
