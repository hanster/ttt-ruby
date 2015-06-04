require 'qt'
require 'tictactoe/gui_game'
require 'tictactoe/board'
require 'tictactoe/player/computer_player'
require 'tictactoe/player/human_player'
require 'tictactoe/marker'
require 'tictactoe/factory/players_factory'
require 'tictactoe/ai/minimax_ai'

module TicTacToe
  class QtGame < Qt::Widget

    slots :play_game, :clicked

    def initialize
      super(nil)
      setWindowTitle('TicTacToe')
      resize(600, 600)
      @set_up_grid = Qt::GridLayout.new(self)
      @players_type_group = create_players_type_group
      @set_up_grid.addWidget(@players_type_group,0,0)

      @board_type_group = create_board_type_group
      @set_up_grid.addWidget(@board_type_group,0,1)

      @set_up_grid.addWidget(create_play_button,0,2)

      @info_label = Qt::Label.new
      @set_up_grid.addWidget(@info_label, 4, 0)
      @ai = Ai::MinimaxAi.new

      show
    end

    def create_play_button
      play_button = Qt::PushButton.new('Play')
      play_button.objectName = 'play_button'
      connect(play_button, SIGNAL(:clicked), self, SLOT(:play_game))
      play_button
    end

    def add_board
      remove_board if @board != nil
      @board = create_board
      @board..setSizePolicy(Qt::SizePolicy::Expanding,Qt::SizePolicy::Expanding)
      @set_up_grid.addLayout(@board, 1, 0,3,3)
    end

    def remove_board
      clear_panels
      @set_up_grid.removeItem(@board)
    end

    def clear_panels
      @panels.each do |panel|
        panel.hide
        @board.removeWidget(panel)
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

    def play_game
      set_up_board_dim
      add_board
      set_up_players
      @game = GuiGame.new(Board.new(@board_dim), @players)
      update_game
    end

    def set_up_players
      players_selection = @players_type_button_group.checkedButton.text
      @players = Factory::PlayersFactory.new(nil, @ai).create_from_string(players_selection)
    end

    def set_up_board_dim
      case @board_type_button_group.checkedButton.text
      when '3x3'
        @board_dim = 3
      when '4x4'
        @board_dim = 4
      end
    end

    def create_players_type_group
      players_type_group = Qt::GroupBox.new('Game Types', self)

      hvh_radio = Qt::RadioButton.new('Human vs Human',self)
      hvc_radio = Qt::RadioButton.new('Human vs Computer',self)
      cvh_radio = Qt::RadioButton.new('Computer vs Human',self)
      cvc_radio = Qt::RadioButton.new('Computer vs Computer',self)
      hvh_radio.setChecked(true)

      vbox = Qt::VBoxLayout.new(players_type_group)
      vbox.addWidget(hvh_radio)
      vbox.addWidget(hvc_radio)
      vbox.addWidget(cvh_radio)
      vbox.addWidget(cvc_radio)

      @players_type_button_group = create_button_group([hvh_radio, hvc_radio, cvh_radio, cvc_radio])
      players_type_group
    end

    def create_board_type_group
      board_type_group = Qt::GroupBox.new('Board Types', self)

      three_radio = Qt::RadioButton.new('3x3',self)
      four_radio = Qt::RadioButton.new('4x4',self)
      three_radio.setChecked(true)

      vbox = Qt::VBoxLayout.new(board_type_group)
      vbox.addWidget(three_radio)
      vbox.addWidget(four_radio)
      @board_type_button_group = create_button_group([three_radio, four_radio])

      board_type_group
    end

    def update_game
      if @game.game_over?
        @info_label.text = @game.end_game_state
      else
        @info_label.text = "Turn = Player #{@game.current_player.marker}"
        next_move = get_player_move
        make_move(find_move_button(next_move)) if next_move
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

    def create_button_group(buttons)
      button_group = Qt::ButtonGroup.new(self)
      buttons.each do |button|
        button_group.addButton(button)
      end
      button_group
    end

    def clicked
      make_move(sender)
    end

    def make_move(button)
      return if @game.game_over?
      if button.text != 'X' && button.text != 'O'
        @game.make_player_move(button.text.to_i - 1)
        button.text = @game.current_player.marker
        button.setStyleSheet("color: red") if button.text == 'X'
        button.setStyleSheet("color: blue") if button.text == 'O'
        @game.switch_current_player
      end
      update_game
    end
  end
end
