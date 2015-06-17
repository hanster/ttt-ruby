require 'Qt'
require 'tictactoe/game'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/game_types'
require 'tictactoe/ui/gui_builder'
require 'tictactoe/ui/menu_group'

module TicTacToe
  class QtGame < Qt::Widget
    X_MARKER_COLOR = "color: red"
    O_MARKER_COLOR = "color: blue"
    TICTACTOE = 'TicTacToe'
    PLAY_BUTTON_TEXT = 'Play'
    PLAY_BUTTON_NAME = 'play_button'
    GAME_BOARD_NAME = 'game_board'
    PLAYER_TYPE_BUTTON_GROUP_NAME = 'player_type_b_group'
    BOARD_TYPE_BUTTON_GROUP_NAME = 'board_type_b_group'
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
      @ui = Gui.new
      build_gui_objects
      @ui.add_label(@info_label)

      show
    end

    def build_gui_objects
      @grid_board = nil
      @gui_builder = Ui::GuiBuilder.new(self)
      
      @players_menu = Ui::MenuGroup.new(GAME_TYPES_TEXT, GameTypes::get_player_options)
      @board_menu = Ui::MenuGroup.new(BOARD_TYPES_TEXT, GameTypes::get_board_options)

      @info_label = @gui_builder.create_label
      play_button = @gui_builder.create_button(PLAY_BUTTON_NAME, PLAY_BUTTON_TEXT, :play_new_game)
      @set_up_grid = Qt::GridLayout.new(self)
      @set_up_grid.addWidget(@players_menu.group_box, 0, 0)
      @set_up_grid.addWidget(@board_menu.group_box, 0, 1)
      @set_up_grid.addWidget(play_button, 0, 2)
      @set_up_grid.addWidget(@info_label, 4, 0)
    end

    def add_board(board_dim)
      remove_board unless @grid_board.nil?
      @grid_board = create_board(board_dim)
      @set_up_grid.addLayout(@grid_board, 1, 0, 3, 3)
    end

    def remove_board
      clear_panels
      @set_up_grid.removeItem(@grid_board)
    end

    def clear_panels
      @panels.each do |panel|
        panel.hide
        @grid_board.removeWidget(panel)
        panel.dispose
      end
    end

    def create_board(board_dim)
      @panels = []
      grid_board = Qt::GridLayout.new
      grid_board.objectName = GAME_BOARD_NAME
      dim = board_dim
      (0...(dim*dim)).each do |position|
        panel = create_panel(position, dim, grid_board)
        @panels << panel
      end
      grid_board
    end

    def create_panel(position, dim, grid_board)
      panel = Qt::PushButton.new((position + 1).to_s)
      panel.setSizePolicy(Qt::SizePolicy::Expanding,Qt::SizePolicy::Expanding)
      row, col = position.divmod(dim)
      connect(panel, SIGNAL(:clicked), self, SLOT(:clicked))
      grid_board.addWidget(panel, row, col)
      panel
    end

    def play_new_game
      board = set_up_new_board
      players = set_up_players
      add_board(board.dimension)
      @game = Game.new(board, players, @ui)
      update_game
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

    def find_move_button(move)
      @panels.find do |panel|
        panel.text == (move + 1).to_s
      end
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
      if @game.game_over?
        @game.draw
      else
        @info_label.text = player_turn_message
        next_move = get_player_move
        find_move_button(next_move).click if next_move
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

  class Gui
    WINNER_MESSAGE = "%s wins!"
    DRAW_MESSAGE = "It's a draw!"
    def add_label(info_label)
      @info_label = info_label
    end
    def prompt_for_move(board, marker)

    end

    def clear_screen

    end

    def draw_board(board)

    end

    def display_end_game_message(end_game_state)
      message = ''
      if end_game_state == Board::DRAW
        message = DRAW_MESSAGE
      else
        message = WINNER_MESSAGE % end_game_state
      end
      @info_label.text = "Game Over\n\n" + message
    end
  end
end
