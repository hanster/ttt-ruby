require 'spec_helper'
require 'tictactoe/board'
require 'tictactoe/board_four'

module TicTacToe
  class BoardHelper
    def self.create_initial_board_three(layout)
      Board.new(layout.split(''))
    end
  
    def self.create_initial_board_four(layout)
      BoardFour.new(layout.split(''))
    end
  end
end
