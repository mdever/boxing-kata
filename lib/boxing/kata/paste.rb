require "boxing/kata/item"
require "boxing/kata/constants"

Items ||= Boxing::Kata::Constants::Items

module Boxing
  module Kata
    class Paste < Boxing::Kata::BoxItem
      attr_accessor :color

      def initialize
        super(Items::PASTE, 7.6)
      end
    end
  end
end