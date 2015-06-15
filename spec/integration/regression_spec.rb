require 'tictactoe/ui/console_ui'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/factory/players_factory'
require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/board_helper'

describe 'check full games end in draw with minimax' do
  let(:ui) { TicTacToe::Ui::ConsoleUi.new }
  let(:ai) { TicTacToe::Ai::MinimaxAi.new }
  let(:player_factory) { TicTacToe::Factory::PlayersFactory.new(ui, ai) }
  let(:players) { player_factory.create(TicTacToe::Factory::PlayersFactory::CVC_GAME_TYPE) }

  it 'plays 50 games and all end in a draw' do
    50.times do |i|
      game = TicTacToe::Game.new(TicTacToe::Board.make_board(4), players, ui)
      game.run
      expect(game.draw?).to be true
    end
  end

  it 'draws in a previously winning game setup' do
    board = TicTacToe::BoardHelper.create_initial_board_four('-OX-O-----X----X')
    game = TicTacToe::Game.new(board, players, ui)
    game.update_current_player
    game.run
    expect(game.draw?).to be true
  end

  it 'draws in a previously winning game setup 2' do
    board = TicTacToe::BoardHelper.create_initial_board_four('O--X----O--X--X-')
    game = TicTacToe::Game.new(board, players, ui)
    game.update_current_player
    game.run
    expect(game.draw?).to be true
  end

  it 'plays a C v C game to a draw' do
    game = TicTacToe::Game.new(TicTacToe::Board.make_board(4), players, ui)
    game.run
    expect(game.draw?).to be true
  end
end

