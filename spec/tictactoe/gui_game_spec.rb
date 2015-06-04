require 'spec_helper'
require 'tictactoe/gui_game'
require 'tictactoe/board'
require 'tictactoe/player/computer_player'
require 'tictactoe/player/human_player'
require 'tictactoe/marker'

module TicTacToe
  describe GuiGame do
    let(:board) { Board.new }
    let(:players) { [Player::ComputerPlayer.new(Marker::X_MARKER), Player::HumanPlayer.new(nil, Marker::O_MARKER)] }
    let(:game) { GuiGame.new(board, players) }

    it 'has a current player' do
      expect(game.current_player).to be_kind_of(Player::ComputerPlayer)
    end

    it 'switches the current player' do
      prev_player_marker = game.current_player.marker
      game.switch_current_player
      expect(game.current_player.marker == prev_player_marker).to be false
    end

    it 'cycles round to the first player after switching twice' do
      prev_player_marker = game.current_player.marker
      game.switch_current_player
      game.switch_current_player

      expect(game.current_player.marker == prev_player_marker).to be true
    end

    it 'makes a move on the board' do
      expect(board).to receive(:move)
      game.make_player_move(0)
    end

    it 'checks if the game is over' do
      expect(board).to receive(:game_over?)
      game.game_over?
    end

    it 'returns a move when the computer is the current player' do
      player_move = game.get_player_move
      expect(board.move_available?(player_move)).to be true
    end

    it 'returns nil for a move when the human is the current player' do
      game.switch_current_player
      player_move = game.get_player_move
      expect(player_move).to be nil
    end

    it 'returns the board game over message' do
      expect(board).to receive(:game_over_message)
      game.end_game_state
    end
  end
end
