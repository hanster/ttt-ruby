require 'spec_helper'
require 'tictactoe/board'
require 'tictactoe/board_four'

module TicTacToe
  class BoardHelper
    def self.create_initial_board_three(layout)
      Board.new(3, layout.split(''))
    end
  
    def self.create_initial_board_four(layout)
      BoardFour.new(4, layout.split(''))
    end
  end
end
