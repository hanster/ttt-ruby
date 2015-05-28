module TicTacToe
  module Ui
    class InputNewGame
      PLAY_AGAIN_PROMPT = "Do you want to play again?"
      INVALID_PLAY_AGAIN_PROMPT = "Invalid input (y/n)"
      YES_INPUT = 'y'
      NO_INPUT = 'n'
      attr_reader :value

      def initialize(input)
        @input = input
      end

      def parse_input
        @value = @input.gets.chomp
      end

      def prompt_message
        PLAY_AGAIN_PROMPT
      end

      def invalid_message
        INVALID_PLAY_AGAIN_PROMPT
      end

      def valid?
        @value == YES_INPUT || @value == NO_INPUT
      end
    end
  end
end
