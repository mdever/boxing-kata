require_relative "constants.rb"
require "boxing/kata/box"

Colors = Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class Preference
      attr_accessor :id, :name, :brush_color, :primary_insured_id, :contract_effective_date
      
      def initialize(id, name, brush_color, primary_insured_id, contract_effective_date=nil)
        @id = id
        @name = name
        @brush_color = brush_color
        @primary_insured_id = primary_insured_id
        @contract_effective_date = contract_effective_date
      end
    end

    class Preferences
      attr_accessor :preferences

      def initialize
        @preferences = []
      end

      def length
        @preferences.length
      end

      def <<(preference)
        add_preference(preference)
      end

      def add_preference(preference)
        @preferences.push(preference)
        @preferences = @preferences.sort { |a, b| a.brush_color <=> b.brush_color }
      end

      def contract_effective_date
        if @contract_effective_date == nil
          @preferences.find do |pref|
            if pref.contract_effective_date != nil
              @contract_effective_date = pref.contract_effective_date
            end
          end
        end

        @contract_effective_date
      end

      # Linear search but we're not talking about families of 1,000,000 people, right?
      def find_by_id(id)
        @preferences.find { |pref| pref.id == id }
      end
      
      def color_count
        colors = {}
        Colors::AVAILABLE_COLORS.each { |color| colors[color.to_sym] = 0 }

        @preferences.each do |pref|
          colors[pref.brush_color.to_sym] += 1
        end

        colors
      end

      def starter_boxes
        boxes = []
        eff_date = self.contract_effective_date
        current_box = StarterBox.new(eff_date)
        @preferences.each do |pref|
          current_box.add_brush(Brush.new(pref.brush_color))
          current_box.add_replacement_head(ReplacementHead.new(pref.brush_color))
          if current_box.brushes.length == 2
            current_box.add_paste(Paste.new)
            boxes << current_box
            current_box = StarterBox.new(eff_date)
          end
        end

        if current_box.brushes.length > 0
          current_box.add_paste(Paste.new)
          boxes << current_box
        end
      end

      def replacement_boxes
        boxes = []
        eff_date = self.contract_effective_date
        current_box = RefillBox.new(eff_date)
        @preferences.each do |pref|
          current_box.add_replacement_head(ReplacementHead.new(pref.brush_color))
          if current_box.replacement_heads.length == 4
            current_box.add_paste(Paste.new)
            boxes << current_box
            current_box = RefillBox.new(eff_date)
          end
        end

        if current_box.replacement_heads.length > 0
          current_box.add_paste(Paste.new)
          boxes << current_box
        end
      end
    end
  end
end
