require 'tictactoe/marker'
require 'tictactoe/game_types'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/player/human_player'
require 'tictactoe/game'
require 'tictactoe/board'

module TicTacToe
  class GameSetup
    include GameTypes
    include Marker
    BOARD_TYPES_PROMPT = "Board Types:\n" +
      "1 - 2x2\n" +
      "2 - 3x3\n" +
      "3 - 4x4\n"

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
      game_type = @ui.prompt_game_type(GAME_TYPES_PROMPT)
      Factory::PlayersFactory.new(@ui, @ai).create(game_type)
    end

    def choose_board_type
      board_type = @ui.prompt_board_type(BOARD_TYPES_PROMPT)
      Factory::BoardFactory.new.create(board_type)
    end
  end
end
