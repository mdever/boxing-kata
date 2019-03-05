require "boxing/kata/item"
require "boxing/kata/constants"

Items ||= Boxing::Kata::Constants::Items

module Boxing
  module Kata
    class ReplacementHead < Boxing::Kata::BoxItem
      attr_accessor :color

      def initialize(color)
        super(Items::REPLACEMENT_HEAD, 1)
        @color = color
      end

      def self.pluralize(amount)
        if amount == 1
          "replacement head"
        else
          "replacement heads"
        end
      end
    end
  end
end
