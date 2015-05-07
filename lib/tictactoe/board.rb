module TicTacToe
  class Board
    BOARD_DIM = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM
    X_MARKER = 'X'
    O_MARKER = 'O'

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

    private

    attr_accessor :positions, :turn

    def next_turn(current_turn)
      current_turn == X_MARKER ? O_MARKER : X_MARKER
    end
  end
end
