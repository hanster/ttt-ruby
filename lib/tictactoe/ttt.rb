require 'tictactoe/game_setup'
require 'tictactoe/ui/console_ui'

module TicTacToe
  class TTT
    def initialize(ui, game_setup)
      @ui = ui
      @game_setup = game_setup
    end

    def run
      loop do
        game = @game_setup.choose_game_type
        game.run
        break unless @ui.prompt_play_again?
      end
      @ui.prompt_good_bye
    end
  end
end
