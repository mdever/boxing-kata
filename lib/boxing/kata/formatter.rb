require "boxing/kata/preferences"
require "boxing/kata/constants"

Colors   ||= Boxing::Kata::Constants::Colors
BoxTypes ||= Boxing::Kata::Constants::BoxTypes

module Boxing
  module Kata
    class BoxingFormatter

      def initialize(preferences)
        @preferences = preferences
      end

      def format_colors
        colors = @preferences.color_count
        "
```
BRUSH PREFERENCES
#{Colors::BLUE}: #{colors[Colors::BLUE.to_sym]}
#{Colors::GREEN}: #{colors[Colors::GREEN.to_sym]}
#{Colors::PINK}: #{colors[Colors::PINK.to_sym]}
```
        "
      end

      def format_starter_boxes
        boxes = @preferences.starter_boxes

        if boxes.length == 0
          return "NO STARTER BOXES GENERATED"
        end

        output = "\n```\n"
        boxes.each do |box|
          output << "STARTER BOX\n"
          output << format_starter_box(box)
        end

        output.chomp!
        output << "```\n\n"

        output
      end

      def format_starter_box(box)
        output = ""
        if box.brushes.length > 1
          if same_color? box 
            brush = box.brushes[0]
            output << "2 #{brush.color} brushes\n"
            output << "2 #{brush.color} replacement heads\n"
          else
            box.brushes.each do |brush|
              output << "1 #{brush.color} brush\n"
              output << "1 #{brush.color} replacement head\n"
            end
          end
        else
          brush = box.brushes[0]
          output << "1 #{brush.color} brush\n"
          output << "1 #{brush.color} replacement head\n"
        end

        if box.paste_kits.length > 1
          output << "2 paste kits\n"
        else 
          output << "1 paste kit\n"
        end

        output << "Schedule: " << box.contract_effective_date.to_s << "\n"

        output << "Mail class: " << box.mail_class << "\n\n"

        output
      end

      def format_refill_boxes
        boxes = @preferences.refill_boxes

        if boxes.length == 0
          return "PLEASE GENERATE STARTER BOXES FIRST"
        end

        output = "\n```\n"
        boxes.each do |box|
          output << "REFILL BOX\n"
          output << format_refill_box(box)
        end

        output.chomp!
        output << "```\n\n"

        output
      end

      def format_refill_box(box)
        output = ""
        blue_heads  = box.replacement_heads_of_color(Colors::BLUE)
        green_heads = box.replacement_heads_of_color(Colors::GREEN)
        pink_heads  = box.replacement_heads_of_color(Colors::PINK)

        if blue_heads > 0
          output << "#{blue_heads} blue #{ReplacementHead.pluralize(blue_heads)}\n"
        end
         
        if green_heads > 0
          output << "#{green_heads} green #{ReplacementHead.pluralize(green_heads)}\n"
        end

        if pink_heads > 0
          output << "#{pink_heads} pink #{ReplacementHead.pluralize(pink_heads)}\n"
        end

        output << "1 paste kit\n"

        output << "Schedule: " 
        
        box.refill_dates.each_with_index do |date, i| 
          output << date.to_s
          if i != box.refill_dates.length - 1
            output << ", "
          end
        end
        output << "\n"

        output << "Mail class: " << box.mail_class << "\n\n"

        output
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