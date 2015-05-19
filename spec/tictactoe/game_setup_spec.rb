require 'spec_helper'
require 'tictactoe/game_setup'
require 'tictactoe/fakes/ui_mock'
require 'tictactoe/player/computer_player'

module TicTacToe
  describe GameSetup do
    let(:ui) { Fakes::UiMock.new }
    let(:ai) { Player::RandomAi.new }
    let(:game_setup) { GameSetup.new(ui, ai) }
    let(:human_player) { Player::HumanPlayer }
    let(:computer_player) { Player::ComputerPlayer }

    def expect_players_to_be(players, player_1, player_2)
      expect(players[0].kind_of?(player_1)).to be true
      expect(players[1].kind_of?(player_2)).to be true
    end

    it "sets up the game" do
      game = game_setup.choose_game_type
      expect(game.kind_of?(Game)).to be true
    end

    it "sets up a game with HvH when the response is 1" do
      ui.game_type_input = GameSetup::HVH_GAME_TYPE
      game = game_setup.choose_game_type
      expect(game.kind_of?(Game)).to be true
      expect_players_to_be(game.players, human_player, human_player)
    end

    it "sets up a game with CvH when the response is 2" do
      ui.game_type_input = GameSetup::CVH_GAME_TYPE
      game = game_setup.choose_game_type
      expect_players_to_be(game.players, computer_player, human_player)
    end

    it "sets up a game with CvH when the response is 3" do
      ui.game_type_input = GameSetup::HVC_GAME_TYPE
      game = game_setup.choose_game_type
      expect_players_to_be(game.players, human_player, computer_player)
    end

    it "sets up a game with CvC when the response is 4" do
      ui.game_type_input = GameSetup::CVC_GAME_TYPE
      game = game_setup.choose_game_type
      expect_players_to_be(game.players, computer_player, computer_player)
    end

    it "displays the game types to the user" do
      game = game_setup.choose_game_type
      expect(ui.display_message_times_called).to eq(1)
    end

  end
end
