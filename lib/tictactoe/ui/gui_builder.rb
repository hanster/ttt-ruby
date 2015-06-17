require 'Qt'

module TicTacToe
  module Ui
    class GuiBuilder
      INFO_LABEL_NAME = 'info_label'
      def initialize(parent)
        @parent = parent
      end

      def create_radio_buttons(options)
        options.reduce([]) do |radio_buttons, option|
          radio_button = Qt::RadioButton.new(option, @parent)
          radio_button.objectName = option
          radio_buttons << radio_button
        end
      end

      def create_button_group(name, buttons)
        button_group = Qt::ButtonGroup.new(@parent)
        button_group.objectName = name
        buttons.each do |button|
          button_group.addButton(button)
        end
        default_button = button_group.buttons.first
        default_button.setChecked(true)
        button_group
      end

      def create_group_box(object_name, radio_buttons)
        group = Qt::GroupBox.new(object_name, @parent)
        layout = Qt::VBoxLayout.new(group)
        radio_buttons.each do |radio_button|
          layout.addWidget(radio_button)
        end
        group
      end

      def create_button(object_name, text, callback)
        button = Qt::PushButton.new(text)
        button.objectName = object_name
        @parent.connect(button, SIGNAL(:clicked), @parent, SLOT(callback))
        button
      end

      def create_label
        label = Qt::Label.new
        label.objectName = INFO_LABEL_NAME
        label
      end


    end
  end
end

