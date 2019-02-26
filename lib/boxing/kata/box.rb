require "boxing/kata/constants"
require "Date"

BoxTypes ||= Boxing::Kata::Constants::BoxTypes
Items    ||= Boxing::Kata::Constants::Items
Colors   ||= Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class Box
      attr_accessor :type, :brushes, :replacement_heads, :contract_effective_date, :paste_kits

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

  class StarterBox < Boxing::Kata::Box
    def initialize(contract_effective_date)
      super(BoxTypes::STARTER, contract_effective_date)
    end
  end

  class RefillBox < Boxing::Kata::Box
    def initialize(contract_effective_date)
      super(BoxTypes::REPLACEMENT, contract_effective_date)
    end

    def refill_dates
      schedule = []
      i = 1

      while true
        next_date = contract_effective_date + (90*i)
        if next_date.year != contract_effective_date.year
          break
        end
        schedule << next_date
        i += 1
      end     

      schedule
    end
  end

  class Item
    attr_accessor :type, :weight

    def initialize(type, weight)
      @type = type
      @weight = weight
    end
  end

  class Brush < Item
    attr_accessor :color

    def initialize(color)
      super(Items::BRUSH, 9)
      @color = color      
    end
  end

  class ReplacementHead < Item
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

  class Paste < Item
    attr_accessor :color

    def initialize
      super(Items::PASTE, 7.6)
    end
  end
end
