module TicTacToe
  module GameTypes
    HVH_GAME_TYPE = 1
    CVH_GAME_TYPE = 2
    HVC_GAME_TYPE = 3
    CVC_GAME_TYPE = 4
    GAME_TYPES_PROMPT = "Game Types:\n" +
      " 1 - Human vs Human\n" +
      " 2 - Computer vs Human\n" +
      " 3 - Human vs Computer\n" +
      " 4 - Computer vs Computer\n"
    PLAYER_OPTIONS = {
      1 => 'Human vs Human',
      2 => 'Computer vs Human',
      3 => 'Human vs Computer',
      4 => 'Computer vs Computer'
    }
    BOARD_OPTIONS = {
      1 => '2x2',
      2 => '3x3',
      3 => '4x4'
    }

    def self.get_player_options
      PLAYER_OPTIONS.values
    end

    def self.get_board_options
      BOARD_OPTIONS.values
    end
  end
end
