require_relative "constants.rb"

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
      end

      # Linear search but we're not talking about families of 1,000,000 people, right?
      def find_by_id(id)
        @preferences.find { |pref| pref.id == id }
      end
      
      def color_count
        colors = {}
        Constants::Colors::AVAILABLE_COLORS.each { |color| colors[color.to_sym] = 0 }

        @preferences.each do |pref|
          colors[pref.brush_color.to_sym] += 1
        end

        colors
      end 
    end
  end
end
