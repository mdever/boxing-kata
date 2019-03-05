require "boxing/kata/constants"
require "Date"

BoxTypes ||= Boxing::Kata::Constants::BoxTypes
Items    ||= Boxing::Kata::Constants::Items
Colors   ||= Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class Box
      attr_accessor :type, :brushes, :replacement_heads, :contract_effective_date, :paste_kits, :weight

      def initialize(type, contract_effective_date)
        @type = type
        @brushes = []
        @replacement_heads = []
        @paste_kits = []
        @contract_effective_date = contract_effective_date
        @weight = 0
      end

      def add_brush(brush)
        @brushes << brush
        @weight += brush.weight
      end

      def add_replacement_head(head)
        @replacement_heads << head
        @weight += head.weight
      end

      def add_paste(paste)
        @paste_kits << paste
        @weight += paste.weight
      end

      def mail_class
        if @weight >= 16
          @mail_class = "priority"
        else
          @shipping_priority = "first"
        end
      end

      def replacement_heads_of_color(color)
        count = 0
        @replacement_heads.each do |head|
          if head.color == color
            count += 1
          end
        end

        count
      end
    end
  end
end
