module TicTacToe
  class BoardFour < Board
    BOARD_TEMPLATE = 
      "\n" +
      "  %s  |  %s  |  %s  | %s  \n" +
      "-----+-----+-----+-----\n" +
      "  %s  |  %s  |  %s  | %s  \n" +
      "-----+-----+-----+-----\n" +
      "  %s  |  %s |  %s | %s \n" +
      "-----+-----+-----+-----\n" +
      "  %s |  %s |  %s | %s \n\n"
    BOARD_DIM = 4
    BOARD_SIZE = BOARD_DIM * BOARD_DIM

    def initialize(dim = 4, initial_positions = nil)
      @dimension = dim
      @size = @dimension * @dimension
      initial_positions ||= (EMPTY_MARKER * @size).split('')
      @positions = initial_positions
    end

    def move(position, marker)
      new_positions = positions.dup
      new_positions[position] = marker
      BoardFour.new(@dimension, new_positions)
    end

    def get_template
      BOARD_TEMPLATE
    end
  end
end
