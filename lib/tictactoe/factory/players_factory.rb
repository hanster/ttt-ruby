require 'tictactoe/marker'
require 'tictactoe/game_types'
require 'tictactoe/player/computer_player'
require 'tictactoe/player/human_player'

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

      def create_from_string(player_type)
        player_type_code = PLAYER_OPTIONS.key(player_type)
        create(player_type_code)
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
