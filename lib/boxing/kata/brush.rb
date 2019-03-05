require "boxing/kata/item"
require "boxing/kata/constants"

Items ||= Boxing::Kata::Constants::Items

module Boxing
  module Kata
    class Brush < BoxItem
      attr_accessor :color

      def initialize(color)
        super(Items::BRUSH, 9)
        @color = color      
      end
    end
  end
end
