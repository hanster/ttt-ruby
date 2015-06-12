require 'Qt'
require 'tictactoe/gui_game'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/game_types'

module TicTacToe
  class QtGame < Qt::Widget
    X_MARKER_COLOR = "color: red"
    O_MARKER_COLOR = "color: blue"
    TICTACTOE = 'TicTacToe'
    INFO_LABEL_NAME = 'info_label'
    PLAY_BUTTON_TEXT = 'Play'
    PLAY_BUTTON_NAME = 'play_button'
    GAME_BOARD_NAME = 'game_board'
    PLAYER_TYPE_BUTTON_GROUP_NAME = 'player_type_b_group'
    BOARD_TYPE_BUTTON_GROUP_NAME = 'board_type_b_group'
    GAME_TYPES_TEXT = 'Game Types'
    BOARD_TYPES_TEXT = 'Board Types'

    slots :play_new_game, :clicked

    def initialize
      super(nil)
      @grid_board = nil
      setObjectName(TICTACTOE)
      setWindowTitle(TICTACTOE)
      resize(600, 600)
      @set_up_grid = Qt::GridLayout.new(self)
      @players_type_group = create_players_type_group
      @set_up_grid.addWidget(@players_type_group,0,0)

      @board_type_group = create_board_type_group
      @set_up_grid.addWidget(@board_type_group,0,1)

      @set_up_grid.addWidget(create_play_button,0,2)

      @info_label = Qt::Label.new
      @info_label.objectName = INFO_LABEL_NAME
      @set_up_grid.addWidget(@info_label, 4, 0)
      @ai = Ai::MinimaxAi.new

      show
    end

    def create_play_button
      play_button = Qt::PushButton.new(PLAY_BUTTON_TEXT)
      play_button.objectName = PLAY_BUTTON_NAME
      connect(play_button, SIGNAL(:clicked), self, SLOT(:play_new_game))
      play_button
    end

    def add_board
      remove_board unless @grid_board.nil?
      @grid_board = create_board
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

    def create_board
      @panels = []
      grid_board = Qt::GridLayout.new
      grid_board.objectName = GAME_BOARD_NAME
      dim = @board_dim
      (0...(dim*dim)).each do |position|
        panel = Qt::PushButton.new((position + 1).to_s)
        panel.setSizePolicy(Qt::SizePolicy::Expanding,Qt::SizePolicy::Expanding)
        row, col = position.divmod(dim)
        connect(panel, SIGNAL(:clicked), self, SLOT(:clicked))
        grid_board.addWidget(panel, row, col)
        @panels << panel
      end
      grid_board
    end

    def play_new_game
      set_up_board_dim
      add_board
      set_up_players
      @game = GuiGame.new(@board, @players)
      update_game
    end

    def set_up_players
      players_selection = @players_type_button_group.checkedButton.text
      @players = Factory::PlayersFactory.new(nil, @ai).create_from_string(players_selection)
    end

    def set_up_board_dim
      board_selection = @board_type_button_group.checkedButton.text
      @board = Factory::BoardFactory.new.create_from_string(board_selection)
      @board_dim = @board.dimension
    end

    def create_players_type_group
      options = GameTypes::get_player_options
      radio_buttons = create_radio_buttons(options)

      @players_type_button_group = create_button_group(PLAYER_TYPE_BUTTON_GROUP_NAME, radio_buttons)
      create_group_box(GAME_TYPES_TEXT, radio_buttons)
    end

    def create_board_type_group
      options = GameTypes::get_board_options
      radio_buttons = create_radio_buttons(options)

      @board_type_button_group = create_button_group(BOARD_TYPE_BUTTON_GROUP_NAME, radio_buttons)
      create_group_box(BOARD_TYPES_TEXT, radio_buttons)
    end

    def create_group_box(object_name, radio_buttons)
      group = Qt::GroupBox.new(object_name, self)
      layout = Qt::VBoxLayout.new(group)
      radio_buttons.each do |radio_button|
        layout.addWidget(radio_button)
      end
      group
    end

    def create_radio_buttons(options)
      options.reduce([]) do |radio_buttons, option|
        radio_button = Qt::RadioButton.new(option, self)
        radio_button.objectName = option
        radio_buttons << radio_button
      end
    end

    def update_game
      if @game.game_over?
        @info_label.text = @game.end_game_state
      else
        @info_label.text = player_turn_message
        next_move = get_player_move
        find_move_button(next_move).click if next_move
      end
    end

    def player_turn_message
      "Turn = Player #{@game.current_player_marker}"
    end

    def find_move_button(move)
      @panels.find do |panel|
        panel.text == (move + 1).to_s
      end
    end

    def get_player_move
      @game.get_player_move
    end

    def create_button_group(name, buttons)
      button_group = Qt::ButtonGroup.new(self)
      button_group.objectName = name
      buttons.each do |button|
        button_group.addButton(button)
      end
      default_button = button_group.buttons.first
      default_button.setChecked(true)
      button_group
    end

    def clicked
      make_move(sender)
    end

    def make_move(button)
      return if @game.game_over?
      if valid_button_move?(button)
        @game.make_player_move(button.text.to_i - 1)
        button.text = @game.current_player_marker
        colour_button(button)
        @game.switch_current_player
      end
      update_game
    end

    def valid_button_move?(button)
      button.text != Marker::X_MARKER && button.text != Marker::O_MARKER
    end

    def colour_button(button)
      button.setStyleSheet(X_MARKER_COLOR) if button.text == Marker::X_MARKER
      button.setStyleSheet(O_MARKER_COLOR) if button.text == Marker::O_MARKER
    end
  end
end
