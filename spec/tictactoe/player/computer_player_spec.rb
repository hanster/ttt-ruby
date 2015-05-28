require 'spec_helper'
require 'tictactoe/player/computer_player'
require 'tictactoe/marker'
require 'tictactoe/board_helper'

module TicTacToe
  module Player
    describe ComputerPlayer do
      let(:marker) { Marker::X_MARKER }
      let(:ai) { RandomAi.new }
      let(:player) { ComputerPlayer.new(ai, marker) }

      it "has a set marker after initialization" do
        expect(player.marker).to eq(marker)
      end

      it "returns a valid board move" do
        board = BoardHelper.create_initial_board_three('-OOOXXXOO')
        expect(player.next_move(board)).to eq(0)
      end
    end
  end
end
