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
    HORIZONAL_WIN_CASES = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]]
    VERTICAL_WIN_CASES = HORIZONAL_WIN_CASES.transpose
    DIAGONAL_WIN_CASES = [[0, 5, 10, 15], [3, 6, 9, 12]]
    ALL_WIN_CASES = VERTICAL_WIN_CASES + HORIZONAL_WIN_CASES + DIAGONAL_WIN_CASES

    def initialize(initial_positions = (EMPTY_MARKER * BOARD_SIZE).split(''))
      super(initial_positions)
    end

    def move(position, marker)
      new_positions = positions.dup
      new_positions[position] = marker
      BoardFour.new(new_positions)
    end

    def get_template
      BOARD_TEMPLATE
    end

    private 

    def get_win_cases
      ALL_WIN_CASES
    end
  end
end
