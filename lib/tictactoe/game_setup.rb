require 'tictactoe/marker'
require 'tictactoe/player/human_player'
require 'tictactoe/game'
require 'tictactoe/board'

module TicTacToe
  class GameSetup
    include Marker
    HVH_GAME_TYPE = 1
    CVH_GAME_TYPE = 2
    HVC_GAME_TYPE = 3
    CVC_GAME_TYPE = 4
    GAME_TYPES_PROMPT = "Game Types:\n" +
      " 1 - Human vs Human\n" +
      " 2 - Computer vs Human\n" +
      " 3 - Human vs Computer\n" +
      " 4 - Computer vs Computer\n"

    def initialize(ui, ai)
      @ui = ui
      @ai = ai
    end

    def choose_game_type
      @ui.clear_screen
      @ui.display_message(GAME_TYPES_PROMPT)
      players = []

      # polymorphism? generalise somehow
      case @ui.prompt_game_type
      when HVH_GAME_TYPE
        players = [human_player(X_MARKER), human_player(O_MARKER)]
      when CVH_GAME_TYPE
        players = [computer_player(X_MARKER), human_player(O_MARKER)]
      when HVC_GAME_TYPE
        players = [human_player(X_MARKER), computer_player(O_MARKER)]
      when CVC_GAME_TYPE
        players = [computer_player(X_MARKER), computer_player(O_MARKER)]
      else
        players = [human_player(X_MARKER), human_player(O_MARKER)]
      end

      Game.new(Board.new, players, @ui)
    end

    private
    
    def computer_player(marker)
      Player::ComputerPlayer.new(@ai, marker)
    end

    def human_player(marker)
      Player::HumanPlayer.new(@ui, marker)
    end
  end
end
