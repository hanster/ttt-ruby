require 'Qt'
require 'tictactoe/game'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/ui/graphical_ui'

module TicTacToe
  class QtGame < Qt::Widget
    X_MARKER_COLOR = "color: red"
    O_MARKER_COLOR = "color: blue"
    TICTACTOE = 'TicTacToe'
    GAME_BOARD_NAME = 'game_board'
    GAME_TYPES_TEXT = 'Game Types'
    BOARD_TYPES_TEXT = 'Board Types'
    PLAYER_TURN_TEXT = "Turn = Player %s"

    slots :play_new_game, :clicked

    def initialize
      super(nil)
      setObjectName(TICTACTOE)
      setWindowTitle(TICTACTOE)
      resize(600, 600)
      @ai = Ai::MinimaxAi.new
      @ui = Ui::GraphicalUi.new(self)
    end

    def play_new_game
      setup_game
      update_game
    end

    def setup_game
      board = set_up_new_board
      players = set_up_players

      @ui.new_gui_board(board)
      @game = Game.new(board, players, @ui)
    end

    def set_up_players
      players_selection = @ui.get_players_selection
      players = Factory::PlayersFactory.new(@ui, @ai).create_from_string(players_selection)
    end

    def set_up_new_board
      board_selection = @ui.get_board_selection
      Factory::BoardFactory.new.create_from_string(board_selection)
    end

    def player_turn_message
      PLAYER_TURN_TEXT % @game.current_player_marker
    end

    def get_player_move
      @game.get_player_move
    end

    def clicked
      return if cannot_make_move(sender)
      make_move(sender)
      update_game
    end

    def update_game
      @game.draw
      unless @game.game_over?
        @ui.set_info_label(player_turn_message)
        next_move = get_player_move
        @ui.click_board_panel(next_move) if next_move
      end
    end

    def cannot_make_move(sender)
      @game.game_over? || invalid_button_move?(sender)
    end

    def make_move(sender)
      @game.make_player_move(sender.text.to_i - 1)
      sender.text = @game.current_player_marker
      colour_button(sender)
      @game.update_current_player
    end

    def invalid_button_move?(button)
      button.text == Marker::X_MARKER || button.text == Marker::O_MARKER
    end

    def colour_button(button)
      button.setStyleSheet(X_MARKER_COLOR) if button.text == Marker::X_MARKER
      button.setStyleSheet(O_MARKER_COLOR) if button.text == Marker::O_MARKER
    end
  end
end
