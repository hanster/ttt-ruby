require 'spec_helper'
require 'tictactoe/qt_game'
require 'qt'

module TicTacToe
  describe QtGame do
    before(:all) do
      app = Qt::Application.new(ARGV)
    end

    let(:window) { QtGame.new }

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
    
    def find_widget(name)
      window.children.find{ |w| w.object_name==name }
    end
  end
end
