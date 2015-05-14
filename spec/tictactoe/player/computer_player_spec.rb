require 'spec_helper'
require 'tictactoe/player/computer_player'
require 'tictactoe/marker'

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
        board = Board.new('-OOOXXXOO')
        expect(player.next_move(board)).to eq(0)
      end
    end
  end
end
