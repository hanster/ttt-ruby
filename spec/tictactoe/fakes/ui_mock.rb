module TicTacToe
  module Fakes
    class UiMock
      attr_reader :draw_board_times_called, :clear_screen_times_called, :display_message_times_called
      attr_accessor :game_type_input

      def initialize
        @draw_board_times_called = 0
        @clear_screen_times_called = 0
        @display_message_times_called = 0
      end

      def draw_board(board)
        @draw_board_times_called += 1
      end

      def clear_screen
        @clear_screen_times_called += 1
      end

      def display_message(message)
        @display_message_times_called += 1
      end

      def prompt_game_type
        @game_type_input
      end

    end
  end
end
