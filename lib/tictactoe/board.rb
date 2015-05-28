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
    DRAW = 'draw'
    ONGOING = 'ongoing'

    def initialize(dim = 3, initial_positions = nil)
      @dimension = dim
      @size = @dimension * @dimension
      initial_positions ||= (EMPTY_MARKER * @size).split('')
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
      Board.new(@dimension, new_positions)
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

    def horizontal_wins
      (0...@dimension).inject([]) do |wins, row|
        start_row_index = row * @dimension
        end_row_index = (row + 1) * @dimension
        wins << (start_row_index...end_row_index).to_a
      end
    end

    def vertical_wins
      horizontal_wins.transpose
    end

    def diagonal_wins
      wins = []
      left_right = []
      (0...@dimension).each do |row|
        left_right << row + row * @dimension
      end
      right_left = []
      (1..@dimension).each do |row|
        right_left << row * @dimension - row
      end
      wins << left_right << right_left
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
      won?(O_MARKER) || won?(X_MARKER)
    end

    def no_more_moves?
      @no_more_moves ||= available_moves.count == 0
    end

    def get_win_cases
      horizontal_wins + vertical_wins + diagonal_wins
    end
  end
end
