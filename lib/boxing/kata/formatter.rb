require "boxing/kata/preferences"
require "boxing/kata/constants"

Colors = Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class BoxingFormatter

      def initialize(preferences)
        @preferences = preferences
      end

      def format_colors(colors)
        "
        BRUSH PREFERENCES
        #{Colors::BLUE}: #{colors[Colors::BLUE.to_sym]}
        #{Colors::GREEN}: #{colors[Colors::GREEN.to_sym]}
        #{Colors::PINK}: #{colors[Colors::PINK.to_sym]}
        "
      end

      def format_starter_boxes(colors)
        if colors.empty?
          "NO STARTER BOXES GENERATED"
        end

        boxes = []

        for color in colors.keys.sort
          box = format_starter_box(color.to_s, colors[color])
          boxes << box
        end

        boxes.join("\n\n");

        boxes
      end

      def format_starter_box(color, count)
        output = "STARTER BOX\n"
        output << "#{count*2} #{color} brushes\n"
        output << "#{count*2} #{color} replacement heads"

        output
      end
    end
  end
end