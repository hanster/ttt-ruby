require 'spec_helper'
require 'tictactoe/board'

module TicTacToe
  class BoardHelper
    def self.create_initial_board_three(layout)
      Board.make_board(3, layout.split(''))
    end
  
    def self.create_initial_board_four(layout)
      Board.make_board(4, layout.split(''))
    end
  end
end
