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

      def format_starter_boxes(boxes)
        if boxes.length == 0
          return "PLEASE GENERATE STARTER BOXES FIRST"
        end

        output = ""
        boxes.each do |box|
          output << "STARTER BOX\n"
          output << format_starter_box(box)
          output << "\n"
        end
        output
      end

      def format_starter_box(box)
        output = ""
        if box.brushes.length > 2
          if same_color? box 
            output << "2 " << brush.color << "brushes\n"
            output << "2 " << brush.color << "replacement heads\n"
          else
            box.brushes.each do |item|
              output << "1 " << brush.color << "brush"
              output << "1 " << brush.color << "replacement head"
            end
          end
        else
          output << "1 " << brush.color << "brush\n"
          output << "1 " << brush.color << "replacement head\n"
        end

        if box.paste_kits.length > 1
          output << "2 paste kits"
        else 
          output << "1 paste kit"
        end

        output << "Schedule: " << box.contract_effective_date

        output << "Mail class: " << box.mail_class
      end

      def format_refill_box
        
      end

      def same_color?(box)
        color = ""

        box.brushes.each do |brush|
          if color == ""
            color = brush.color
          elsif brush.color != color
            return false
          end
        end

        return true
      end
    end
  end
end