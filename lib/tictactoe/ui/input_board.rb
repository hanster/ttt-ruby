module TicTacToe
  module Ui
    class InputBoard
      BOARD_TYPE_PROMPT = "Enter board type: "
      INVALID_BOARD_TYPE_PROMPT = "Invalid board type."
      VALID_BOARD_INPUTS = [1, 2, 3]
      attr_reader :value

      def initialize(input)
        @input = input
      end

      def parse_input
        @value = convert_input_to_board_type(@input.gets)
      end

      def prompt_message
        BOARD_TYPE_PROMPT
      end

      def invalid_message 
        INVALID_BOARD_TYPE_PROMPT
      end

      def valid?
        VALID_BOARD_INPUTS.include?(@value)
      end

      private 

      def convert_input_to_board_type(value)
        value[/^[1-3]$/] && value.to_i
      end
    end
  end
end
