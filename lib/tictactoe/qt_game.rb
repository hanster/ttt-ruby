require 'Qt'
require 'tictactoe/game'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/game_types'
require 'tictactoe/ui/gui_builder'
require 'tictactoe/ui/menu_group'
require 'tictactoe/ui/gui_board'
require 'tictactoe/ui/graphical_ui'

module TicTacToe
  class QtGame < Qt::Widget
    X_MARKER_COLOR = "color: red"
    O_MARKER_COLOR = "color: blue"
    TICTACTOE = 'TicTacToe'
    PLAY_BUTTON_TEXT = 'Play'
    PLAY_BUTTON_NAME = 'play_button'
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
      @ui = Ui::GraphicalUi.new
      build_gui_objects
      @ui.add_label(@info_label)
    end

    def build_gui_objects
      @gui_builder = Ui::GuiBuilder.new(self)

      @players_menu = Ui::MenuGroup.new(GAME_TYPES_TEXT, GameTypes::get_player_options)
      @board_menu = Ui::MenuGroup.new(BOARD_TYPES_TEXT, GameTypes::get_board_options)
      @gui_board = Ui::GuiBoard.new
      @gui_board.register_panel_on_click(self, :clicked)

      @info_label = @gui_builder.create_label
      play_button = @gui_builder.create_button(PLAY_BUTTON_NAME, PLAY_BUTTON_TEXT, :play_new_game)
      @set_up_grid = Qt::GridLayout.new(self)
      @set_up_grid.addLayout(@gui_board, 1, 0, 3, 3)
      @set_up_grid.addWidget(@players_menu.group_box, 0, 0)
      @set_up_grid.addWidget(@board_menu.group_box, 0, 1)
      @set_up_grid.addWidget(play_button, 0, 2)
      @set_up_grid.addWidget(@info_label, 4, 0)
    end

    def play_new_game
      setup_game
      update_game
    end

    def setup_game
      board = set_up_new_board
      players = set_up_players

      @gui_board.new_board(board.dimension)
      @game = Game.new(board, players, @ui)
    end

    def set_up_players
      players_selection = @players_menu.selected_option
      players = Factory::PlayersFactory.new(@ui, @ai).create_from_string(players_selection)
    end

    def set_up_new_board
      board_selection = @board_menu.selected_option
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
        @info_label.text = player_turn_message
        next_move = get_player_move
        @gui_board.click_panel(next_move) if next_move
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
