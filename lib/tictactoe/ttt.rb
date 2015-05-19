require 'tictactoe/game_setup'
require 'tictactoe/game_loop'
require 'tictactoe/ui/console_ui'
require 'tictactoe/player/computer_player'
require 'tictactoe/ai/minimax_ai'

module TicTacToe
  class TTT
    def run
      loop do
        ui = Ui::ConsoleUi.new
        ai = Ai::MinimaxAi.new
        game = GameSetup.new(ui, ai).choose_game_type
        GameLoop.new(game).run
        break unless ui.prompt_play_again?
      end
    end
  end
end
