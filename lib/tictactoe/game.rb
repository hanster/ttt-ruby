require 'tictactoe/ui/console_ui'

module TicTacToe
  class Game
    PLAYER_1 = 0

    PLAYER_2 = 1

    attr_reader :players

    #ui naming display /console?
    def initialize(board, players, ui = Ui::ConsoleUi.new)
      @board = board
      @players = players
      @current_player = @players[PLAYER_1]
      @ui = ui
    end

    def update
      make_player_move
      switch_current_player
    end

    def draw
      @ui.clear_screen
      @ui.draw_board(@board)
      @ui.display_message(@board.game_over_message) if game_over?
    end

    def running?
      !@board.game_over?
    end

    def game_over?
      @board.game_over?
    end

    def run
      draw
      until game_over?
        update
        draw
      end
    end

    private

    def make_player_move
      move = @current_player.next_move(@board)
      @board = @board.move(move, @current_player.marker)
    end

    def switch_current_player
      @current_player = @current_player == @players[PLAYER_1] ? @players[PLAYER_2] : @players[PLAYER_1]
    end
  end
end
