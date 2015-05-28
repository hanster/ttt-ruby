module TicTacToe
  module Ui
    class InputGameType
      ENTER_GAME_TYPE_PROMPT = "Enter the game type: "
      INVALID_GAME_TYPE_PROMPT = "Invalid game type."
      attr_reader :value

      def initialize(input)
        @input = input
      end

      def parse_input
        @value = convert_input_to_game_type(@input.gets)
      end

      def prompt_message
        ENTER_GAME_TYPE_PROMPT
      end

      def invalid_message
        INVALID_GAME_TYPE_PROMPT
      end

      def valid?
        @value
      end

      private

      def convert_input_to_game_type(value)
        value[/^[1-4]$/] && value.to_i
      end
    end
  end
end
