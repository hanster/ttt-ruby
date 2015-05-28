require 'tictactoe/marker'
require 'tictactoe/game_types'

module TicTacToe
  module Factory
    class PlayersFactory
      include GameTypes
      include Marker
      def initialize(ui, ai)
        @ui = ui
        @ai = ai
      end

      def create(player_types)
        case player_types
        when HVH_GAME_TYPE
          players = [human(X_MARKER), human(O_MARKER)]
        when CVH_GAME_TYPE
          players = [computer(X_MARKER), human(O_MARKER)]
        when HVC_GAME_TYPE
          players = [human(X_MARKER), computer(O_MARKER)]
        when CVC_GAME_TYPE
          players = [computer(X_MARKER), computer(O_MARKER)]
        else
          players = [human(X_MARKER), human(O_MARKER)]
        end
      end

      private

      def computer(marker)
        Player::ComputerPlayer.new(@ai, marker)
      end

      def human(marker)
        Player::HumanPlayer.new(@ui, marker)
      end
    end
  end
end
