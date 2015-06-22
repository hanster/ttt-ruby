require 'tictactoe/marker'
require 'tictactoe/win_case_calculator'

module TicTacToe
  class Board
    include Marker

    attr_reader :dimension
    DRAW = 'draw'
    ONGOING = 'ongoing'

    def initialize(dim, initial_positions, win_case_calculator)
      @dimension = dim
      @positions = initial_positions
      @win_case_calculator = win_case_calculator
    end

    def self.make_board(dim, initial_positions = nil)
      initial_positions ||= (EMPTY_MARKER * dim * dim).split('')
      win_case_calculator = WinCaseCalculator.new(dim)
      Board.new(dim, initial_positions, win_case_calculator)
    end

    def calculate_state
      a_winner = winner
      return a_winner if a_winner == X_MARKER || a_winner == O_MARKER
      if no_more_moves?
        DRAW
      else
        ONGOING
      end
    end

    def winner
      get_win_cases.each do |win_case|
        return positions[win_case[0]] if win_case_winner?(win_case)
      end
    end

    def win_case_winner?(win_case)
      win_case.all? do |position|
        positions[position] != EMPTY_MARKER && positions[position] == positions[win_case[0]]
      end
    end

    def move(position, marker)
      new_positions = positions.dup
      new_positions[position] = marker
      Board.new(@dimension, new_positions, @win_case_calculator)
    end

    def string_positions
      positions.join
    end

    def available_moves
      @available_moves ||= positions_with_mark(EMPTY_MARKER)
    end

    def move_available?(move)
      positions[move] == EMPTY_MARKER
    end

    def game_over?
      no_more_moves? || has_anyone_won?
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

    def marker_at_position(position)
      positions[position]
    end

    def all_moves
      (0...positions.length).to_a
    end

    def game_over_state
      calculate_state
    end

    def draw?
      @state ||= calculate_state
      @state == DRAW
    end

    def horizontal_wins
      @win_case_calculator.horizontal_wins
    end

    def vertical_wins
      @win_case_calculator.vertical_wins
    end

    def diagonal_wins
      @win_case_calculator.diagonal_wins
    end

    def number_of_moves_made
      positions.length - available_moves.length
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
