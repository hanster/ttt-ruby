require 'tictactoe/game_setup'
require 'tictactoe/game_loop'
require 'tictactoe/ui/console_ui'
require 'tictactoe/player/computer_player'
require 'tictactoe/ai/minimax_ai'

module TicTacToe
  class TTT
    def initialize(ui, game_setup)
      @ui = ui
      @game_setup = game_setup
    end

    def run
      loop do
        game = @game_setup.choose_game_type
        GameLoop.new(game).run
        break unless @ui.prompt_play_again?
      end
    end
  end
end
