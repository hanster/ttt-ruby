module TicTacToe
  class GameLoop
    def initialize(game)
      @game = game
    end

    def run
      while (game.running?)
        game.update
        game.draw
      end
    end

    private

    attr_reader :game
  end
end
