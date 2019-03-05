require "boxing/kata/box"
require "boxing/kata/constants"

BoxTypes ||= Boxing::Kata::Constants::BoxTypes

module Boxing
  module Kata

    class RefillBox < Boxing::Kata::Box
      def initialize(contract_effective_date)
        super(BoxTypes::REPLACEMENT, contract_effective_date)
      end

      def refill_dates
        schedule = []
        multiple = 1

        loop do
          next_date = contract_effective_date + (90*multiple)
          if next_date.year != contract_effective_date.year
            break
          end
          schedule << next_date
          multiple += 1
        end     

        schedule
      end
    end
  end
end
