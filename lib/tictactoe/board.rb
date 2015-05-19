require 'tictactoe/marker'

module TicTacToe
  class Board
    include Marker

    BOARD_DIM = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM
    VERTICAL_WIN_CASES = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    HORIZONAL_WIN_CASES = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    DIAGONAL_WIN_CASES = [[0, 4, 8], [2, 4, 6]]
    ALL_WIN_CASES = VERTICAL_WIN_CASES + HORIZONAL_WIN_CASES + DIAGONAL_WIN_CASES
    CORNERS = [0, 2, 6, 8]

    def self.initial_board(layout)
      Board.new(layout.split(''))
    end

    def initialize(initial_positions = (EMPTY_MARKER * BOARD_SIZE).split(''))
      @positions = initial_positions
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

    def game_over?
      no_more_moves? || has_anyone_won?
    end

    def has_won?(marker)
      marker_positions = positions_with_mark(marker)
      ALL_WIN_CASES.any? do |win_case|
        (win_case - marker_positions).empty?
      end
    end

    def positions_representation
      positions.each_index.reduce([]) do |result, index|
        result << position_representation(index)
      end
    end

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

    def is_draw?
      no_more_moves? && !has_anyone_won?
    end

    def random_corner_move
      CORNERS.sample
    end

    private

    attr_accessor :positions, :turn

    def position_representation(index)
      return index if positions[index] == EMPTY_MARKER
      positions[index]
    end

    def positions_with_mark(marker)
      positions.each_index.select { |index| positions[index] == marker }
    end

    def has_anyone_won?
      x_marker_positions = positions_with_mark(X_MARKER)
      o_marker_positions = positions_with_mark(O_MARKER)
      ALL_WIN_CASES.any? do |win_case|
        (win_case - x_marker_positions).empty? || (win_case - o_marker_positions).empty?
      end
    end

    def no_more_moves?
      available_moves.count == 0
    end
  end
end
