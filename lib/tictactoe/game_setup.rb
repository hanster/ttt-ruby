require 'tictactoe/marker'
require 'tictactoe/player/human_player'
require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/board_four'

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
    THREE_BOARD = 1
    FOUR_BOARD = 2
    BOARD_TYPES_PROMPT = "Board Types:\n" +
      "1 - 3x3\n" +
      "2 - 4x4\n"

    def initialize(ui, ai)
      @ui = ui
      @ai = ai
    end

    def choose_game_type
      @ui.clear_screen
      Game.new(choose_board_type, choose_players, @ui)
    end

    private

    def choose_players
      case @ui.prompt_game_type(GAME_TYPES_PROMPT)
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
    end

    def choose_board_type
      case @ui.prompt_board_type(BOARD_TYPES_PROMPT)
      when THREE_BOARD
        return Board.new
      when FOUR_BOARD
        return BoardFour.new
      else
        return Board.new
      end
    end

    def computer_player(marker)
      Player::ComputerPlayer.new(@ai, marker)
    end

    def human_player(marker)
      Player::HumanPlayer.new(@ui, marker)
    end
  end
end
