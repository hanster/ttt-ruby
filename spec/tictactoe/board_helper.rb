require 'spec_helper'
require 'tictactoe/board'

module TicTacToe
  class BoardHelper
    def self.create_initial_board_three(layout)
      Board.new(3, layout.split(''))
    end
  
    def self.create_initial_board_four(layout)
      Board.new(4, layout.split(''))
    end
  end
end
