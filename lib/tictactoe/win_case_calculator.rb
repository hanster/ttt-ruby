module TicTacToe
  class WinCaseCalculator
    def initialize(dimension)
      @dimension = dimension
    end

    def horizontal_wins
      @h_win_cases ||= calc_horizontal_wins
    end

    def vertical_wins
      @v_wins ||= calc_vertical_wins
    end

    def diagonal_wins
      @d_wins ||= calc_diagonal_wins
    end

    private 

    def calc_horizontal_wins
      (0...@dimension).inject([]) do |wins, row|
        start_row_index = row * @dimension
        end_row_index = (row + 1) * @dimension
        wins << (start_row_index...end_row_index).to_a
      end
    end

    def calc_vertical_wins
      horizontal_wins.transpose
    end

    def calc_diagonal_wins
      left_right = (0...@dimension).inject([]) do |win, row|
        win << row + row * @dimension
      end
      right_left = (1..@dimension).inject([]) do |win, row|
        win << row * @dimension - row
      end
      [] << left_right << right_left
    end
  end
end
