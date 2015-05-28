require 'spec_helper'
require 'tictactoe/factory/players_factory'
require 'tictactoe/fakes/ui_mock'
require 'tictactoe/player/computer_player'
require 'tictactoe/player/human_player'

module TicTacToe
  module Factory
    describe PlayersFactory do
      let(:ui) { Fakes::UiMock.new }
      let(:ai) { Player::RandomAi.new }
      let(:pf) { PlayersFactory.new(ui, ai) }
      let(:human) { Player::HumanPlayer }
      let(:computer) { Player::ComputerPlayer }

      def expect_players_to_be(players, player_1, player_2)
        expect(players[0].kind_of?(player_1)).to be true
        expect(players[1].kind_of?(player_2)).to be true
      end

      it "returns an array of human players" do
          players = pf.create(1)
          expect_players_to_be(players, human, human)
      end

      it "returns an array of computer and human players" do
          players = pf.create(2)
          expect_players_to_be(players, computer, human)
      end

      it "returns an array of human and computer players" do
          players = pf.create(3)
          expect_players_to_be(players, human, computer)
      end

      it "returns an array of computer players" do
          players = pf.create(4)
          expect_players_to_be(players, computer, computer)
      end
    end
  end
end
