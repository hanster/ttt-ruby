require 'tictactoe/marker'

module TicTacToe
  class Board
    include Marker

    BOARD_TEMPLATE = 
      "\n" +
      "  %s  |  %s  |  %s  \n" +
      "-----+-----+-----\n" +
      "  %s  |  %s  |  %s  \n" +
      "-----+-----+-----\n" +
      "  %s  |  %s  |  %s  \n\n"
    BOARD_DIM = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM
    # use dim to calculate the win cases, but don't want to calculate them dynamically each time as we 
    # create a new board with each move
    HORIZONAL_WIN_CASES = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    VERTICAL_WIN_CASES = HORIZONAL_WIN_CASES.transpose
    DIAGONAL_WIN_CASES = [[0, 4, 8], [2, 4, 6]]
    ALL_WIN_CASES = VERTICAL_WIN_CASES + HORIZONAL_WIN_CASES + DIAGONAL_WIN_CASES
    DRAW = 'draw'
    ONGOING = 'ongoing'


    def self.initial_board(layout)
      Board.new(layout.split(''))
    end

    def initialize(initial_positions = (EMPTY_MARKER * BOARD_SIZE).split(''))
      @positions = initial_positions
    end

    def calculate_state
      if has_won?(X_MARKER)
        X_MARKER
      elsif has_won?(O_MARKER)
        O_MARKER
      elsif no_more_moves?
        DRAW
      else
        ONGOING
      end
    end

    def move(position, marker)
      new_positions = positions.dup
      new_positions[position] = marker
      Board.new(new_positions)
    end

    def string_positions
      positions.join
    end

    def available_moves
      positions_with_mark(EMPTY_MARKER)
    end

    def move_available?(move)
      positions[move] == EMPTY_MARKER
    end

    def game_over?
      no_more_moves? || has_anyone_won?
    end

    def has_won?(marker)
      get_win_cases.any? do |win_case|
        all_positions_in_win_case_have_marker?(win_case, marker)
      end
    end

    def won?(marker)
      @state ||= calculate_state
      @state == marker
    end

    def positions_representation
      positions.each_index.reduce([]) do |result, index|
        result << position_representation(index)
      end
    end

    #ask for winner and display in ui
    def game_over_message
      message = ''
      if (has_won?(O_MARKER))
        message = O_MARKER + ' wins!'
      elsif (has_won?(X_MARKER))
        message = X_MARKER + ' wins!'
      elsif no_more_moves?
        message = "It's a draw!"
      end
      "Game Over\n\n" + message
    end

    def draw?
      @state ||= calculate_state
      @state == DRAW
    end

    def get_template
      BOARD_TEMPLATE
    end

    private

    attr_accessor :positions, :turn

    def all_positions_in_win_case_have_marker?(win_case, marker)
      win_case.all? do |position_index|
        positions[position_index] == marker
      end
    end

    def position_representation(index)
      return index if positions[index] == EMPTY_MARKER
      positions[index]
    end

    def positions_with_mark(marker)
      positions.each_index.select { |index| positions[index] == marker }
    end

    # duplicate code for has_won? but it checks bother markers at the same time for performance gains
    def has_anyone_won?
      has_won?(O_MARKER) || has_won?(X_MARKER)
    end

    def no_more_moves?
      @no_more_moves ||= available_moves.count == 0
    end

    def get_win_cases
      ALL_WIN_CASES
    end
  end
end
