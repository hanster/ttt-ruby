module TicTacToe
  module Marker
    X_MARKER = 'X'
    O_MARKER = 'O'
    EMPTY_MARKER = '-'

    def opponent(marker)
      marker == X_MARKER ? O_MARKER : X_MARKER
    end
  end
end
