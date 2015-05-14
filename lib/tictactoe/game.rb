require 'tictactoe/player/human_player'
require 'tictactoe/ui/console_ui'

module TicTacToe
  class Game
    PLAYER_1 = 0
    PLAYER_2 = 1

    def initialize(board, players, ui = Ui::ConsoleUi.new)
      @board = board
      @players = players
      # Code at wrong level of abstraction? current_player should be the player object
      @current_player = PLAYER_1
      @ui = ui
    end

    def update
      make_player_move
      switch_current_player
    end

    def draw
      @ui.clear_screen
      @ui.draw_board(@board)
      @ui.display_message(@board.game_over_message) if !running?
    end

    def running?
      !@board.game_over?
    end

    private

    def make_player_move
      move = @players[@current_player].next_move(@board)
      @board = @board.move(move, @players[@current_player].marker)
    end

    def switch_current_player
      @current_player = @current_player == PLAYER_1 ? PLAYER_2 : PLAYER_1
    end
  end
end
