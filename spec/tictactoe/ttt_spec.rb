require 'spec_helper'
require 'tictactoe/ttt'
require 'tictactoe/fakes/game'

module TicTacToe
  describe TTT do
    let(:ui) { Fakes::UiMock.new }
    let(:game_setup) { Fakes::GameSetupFake.new }
    
    it "plays through one game" do
      ttt = TTT.new(ui, game_setup)
      ttt.run
      
      expect(game_setup.choose_game_type_times_called).to eq(1)
      expect(ui.prompt_play_again_times_called).to eq(1)
    end

    it "loop while prompt_play_again? is true" do
      ui.play_again_answers = [true, false]
      ttt = TTT.new(ui, game_setup)
      ttt.run
      
      expect(game_setup.choose_game_type_times_called).to eq(2)
      expect(ui.prompt_play_again_times_called).to eq(2)
    end

    it "says goodbye at the end" do
      ttt = TTT.new(ui, game_setup)
      ttt.run
      expect(ui.prompt_good_bye_times_called).to eq(1)
    end
  end

  module Fakes
    class GameSetupFake
      attr_reader :choose_game_type_times_called

      def initialize
        @choose_game_type_times_called = 0
        @games_to_play = 1
      end

      def choose_game_type
        @choose_game_type_times_called += 1
        Fakes::Game.new
      end
    end
  end
end
