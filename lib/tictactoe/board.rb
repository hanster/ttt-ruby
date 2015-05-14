require 'tictactoe/marker'

module TicTacToe
  class Board
    include Marker

    # BOARD_DIM concept not used in the win cases? (Inconsistency?)
    BOARD_DIM = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM
    VERTICAL_WIN_CASES = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    HORIZONAL_WIN_CASES = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    DIAGONAL_WIN_CASES = [[0, 4, 8], [2, 4, 6]]
    ALL_WIN_CASES = VERTICAL_WIN_CASES + HORIZONAL_WIN_CASES + DIAGONAL_WIN_CASES

    def initialize(initial_positions = EMPTY_MARKER * BOARD_SIZE)
      @positions = initial_positions.split('')
    end

    def move(position, marker)
      new_positions = self.to_s
      new_positions[position] = marker
      Board.new(new_positions)
    end

    # Shouldn't override to_s
    def to_s
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
        # Code at Wrong Level of Abstraction? - move out to separate method to describe what it does?
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
      # Prefer Polymorphism to If/Else
      # Misplaced responsibility?
      if (has_won?(O_MARKER))
        message = O_MARKER + ' wins!'
      elsif (has_won?(X_MARKER))
        message = X_MARKER + ' wins!'
      elsif no_more_moves?
        message = "It's a draw!"
      end
      "Game Over\n\n" + message
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
      has_won?(X_MARKER) || has_won?(O_MARKER)
    end

    def no_more_moves?
      available_moves.count == 0
    end
  end
end
