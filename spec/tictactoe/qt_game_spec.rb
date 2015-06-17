require 'spec_helper'
require 'tictactoe/qt_game'
require 'Qt'

module TicTacToe
  describe QtGame do
    before(:all) do
      app = Qt::Application.new(ARGV)
    end

    let(:window) { QtGame.new }
    let(:options) { ['radio1', 'radio2', 'radio3'] }
    let(:radio_buttons) { [Qt::RadioButton.new('radio_b1'), Qt::RadioButton.new('radio_b2')] }

    it 'is a window' do
      expect(window).to be_kind_of(Qt::Widget)
      expect(window.parent).to be_nil
    end

    it "has the same number of objects each time play is clicked"  do
      find_widget('play_button').click
      num_children = window.children.size
      find_widget('play_button').click
      after_num_children = window.children.size
      expect(num_children).to eq(after_num_children)
    end
    
    it 'creates an array of radio buttons from an array of strings' do
      gui_builder = Ui::GuiBuilder.new(window)
      radio_buttons = gui_builder.create_radio_buttons(options)
      expect(radio_buttons.size).to be 3
      radio_buttons.each do |radio_button|
        expect(radio_button).to be_kind_of(Qt::RadioButton)
      end
    end

    it 'plays a full computer game' do
      find_widget('Computer vs Computer').click
      find_widget('3x3').click
      find_widget('play_button').click
      expect(find_widget('info_label').text).to eq("Game Over\n\nIt's a draw!")
    end

    it 'displays the correct player turn text' do
      find_widget('play_button').click
      expect(find_widget('info_label').text).to eq("Turn = Player X")
    end

    def find_widget(name)
      window.findChild(Qt::Widget, name)
    end

  end
end
