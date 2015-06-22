module TicTacToe
  module Fakes
    class UiMock
      attr_reader :draw_board_times_called,
        :clear_screen_times_called,
        :display_message_times_called,
        :display_end_game_message_times_called,
        :prompt_play_again_times_called,
        :prompt_good_bye_times_called,
        :prompt_game_type_times_called
      attr_accessor :game_type_input, :play_again_answers

      def initialize
        @draw_board_times_called = 0
        @clear_screen_times_called = 0
        @display_message_times_called = 0
        @display_end_game_message_times_called = 0
        @prompt_play_again_times_called = 0
        @prompt_good_bye_times_called = 0
        @prompt_game_type_times_called = 0
        @play_again_answers = [false]
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

      def display_end_game_message(message)
        @display_end_game_message_times_called += 1
      end

      def prompt_board_type(options)

      end

      def prompt_game_type(options)
        @prompt_game_type_times_called += 1
        @game_type_input
      end

      def prompt_play_again?
        @prompt_play_again_times_called += 1
        @play_again_answers.shift
      end

      def prompt_good_bye
        @prompt_good_bye_times_called += 1
      end
    end
  end
end
