require 'Qt'
require 'tictactoe/gui_game'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/factory/board_factory'
require 'tictactoe/ai/minimax_ai'
require 'tictactoe/game_types'

module TicTacToe
  class QtGame < Qt::Widget

    slots :play_new_game, :clicked

    def initialize
      super(nil)
      @grid_board = nil
      setObjectName('TicTacToe')
      setWindowTitle('TicTacToe')
      resize(600, 600)
      @set_up_grid = Qt::GridLayout.new(self)
      @players_type_group = create_players_type_group
      @set_up_grid.addWidget(@players_type_group,0,0)

      @board_type_group = create_board_type_group
      @set_up_grid.addWidget(@board_type_group,0,1)

      @set_up_grid.addWidget(create_play_button,0,2)

      @info_label = Qt::Label.new
      @info_label.objectName = 'info_label'
      @set_up_grid.addWidget(@info_label, 4, 0)
      @ai = Ai::MinimaxAi.new

      show
    end

    def create_play_button
      play_button = Qt::PushButton.new('Play')
      play_button.objectName = 'play_button'
      connect(play_button, SIGNAL(:clicked), self, SLOT(:play_new_game))
      play_button
    end

    def add_board
      remove_board unless @grid_board.nil?
      @grid_board = create_board
      @set_up_grid.addLayout(@grid_board, 1, 0,3,3)
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
      grid_board.objectName = 'game_board'
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

      @players_type_button_group = create_button_group('player_type_b_group', radio_buttons)
      create_group_box('Game Types', radio_buttons)
    end

    def create_board_type_group
      options = GameTypes::get_board_options
      radio_buttons = create_radio_buttons(options)

      @board_type_button_group = create_button_group('board_type_b_group', radio_buttons)
      create_group_box('Board Types', radio_buttons)
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
        @info_label.text = "Turn = Player #{@game.current_player_marker}"
        next_move = get_player_move
        find_move_button(next_move).click if next_move
      end
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
      button.text != 'X' && button.text != 'O'
    end

    def colour_button(button)
      button.setStyleSheet("color: red") if button.text == 'X'
      button.setStyleSheet("color: blue") if button.text == 'O'
    end
  end
end
