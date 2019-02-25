require "boxing/kata/constants"
require "Date"

BoxTypes = Boxing::Kata::Constants::BoxTypes
Items   = Boxing::Kata::Constants::Items
Colors  = Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class Box
      attr_accessor :type, :brushes, :replacement_heads, :contract_effective_date

      def initialize(type, contract_effective_date)
        @type = type
        @brushes = []
        @replacement_heads = []
        @paste_tubes = []
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
        @paste_tubes << paste
        @weight += paste.weight
      end

      def mail_class
        if @weight >= 16
          @mail_class = "priority"
        else
          @shipping_priority = "first"
        end
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
      i = 3
      ((12 - contract_effective_date.month)/3).times do 
        schedule << (contract_effective_date >> i)
        i += 3
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
  end

  class Paste < Item
    attr_accessor :color

    def initialize
      super(Items::PASTE, 7.6)
    end
  end
end
