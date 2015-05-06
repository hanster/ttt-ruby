module TicTacToe
  class Board
    BOARD_DIM = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM
    X_MARKER = 'X'
    O_MARKER = 'O'
    VERTICAL_WIN_CASES = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    HORIZONAL_WIN_CASES = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    DIAGONAL_WIN_CASES = [[0, 4, 8], [2, 4, 6]]
    ALL_WIN_CASES = VERTICAL_WIN_CASES + HORIZONAL_WIN_CASES + DIAGONAL_WIN_CASES

    def initialize(initial_positions = '-' * BOARD_SIZE, initial_turn = X_MARKER)
      @turn = initial_turn
      @positions = initial_positions.split('')
    end

    def move(position)
      new_positions = self.to_s
      new_positions[position] = turn
      Board.new(new_positions, next_turn(turn))
    end

    def to_s
      positions.join
    end

    def available_positions
      positions.each_with_index.inject([]) do |avail_positions, (value, index)|
        avail_positions << index if value == '-'
        avail_positions
      end
    end

    def game_over?
      no_more_moves? || has_anyone_won?
    end

    def has_won?(marker)
      marker_positions = positions_with_mark(marker)
      ALL_WIN_CASES.each do |win_case|
        return true if (win_case - marker_positions).empty?
      end
      false
    end

    private

    attr_accessor :positions, :turn

    def positions_with_mark(marker)
      positions.each_index.select { |index| positions[index] == marker }
    end

    def next_turn(current_turn)
      current_turn == X_MARKER ? O_MARKER : X_MARKER
    end

    def has_anyone_won?
      has_won?(X_MARKER) || has_won?(O_MARKER)
    end

    def no_more_moves?
      available_positions.count == 0
    end
  end
end
