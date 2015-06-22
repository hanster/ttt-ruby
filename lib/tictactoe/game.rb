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
      @display = ui
    end

    def update
      make_player_move(get_player_move)
      update_current_player
    end

    def draw
      @display.clear_screen
      @display.draw_board(@board)
      @display.display_end_game_message(end_game_state) if game_over?
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

    def update_current_player
      @current_player = @board.number_of_moves_made.even? ? @players[PLAYER_1] : @players[PLAYER_2]
    end
    
    def end_game_state
      @board.game_over_state
    end

    def current_player_marker
      @current_player.marker
    end

    def get_player_move
      @current_player.next_move(@board)
    end

    def make_player_move(move)
      @board = @board.move(move, @current_player.marker) if move
    end
  end
end
