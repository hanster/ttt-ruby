require 'tictactoe/marker'
require 'tictactoe/player/computer_player'

module TicTacToe
  class GuiGame
    PLAYER_1 = 0
    PLAYER_2 = 1

    attr_reader :current_player

    def initialize(board, players)
      @board = board
      @players = players
      @current_player = players[0]
    end

    def switch_current_player
      @current_player = @current_player == @players[PLAYER_1] ? @players[PLAYER_2] : @players[PLAYER_1]
    end

    def get_player_move
      @current_player.next_move(@board) if @current_player.kind_of?(Player::ComputerPlayer)
    end

    def make_player_move(move)
      @board = @board.move(move, @current_player.marker)
    end

    def end_game_state
      @board.game_over_message
    end

    def game_over?
      @board.game_over?
    end
  end
end
