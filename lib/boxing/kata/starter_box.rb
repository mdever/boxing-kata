require "boxing/kata/box"
require "boxing/kata/constants"

BoxTypes ||= Boxing::Kata::Contants::BoxTypes

module Boxing
  module Kata
    class StarterBox < Boxing::Kata::Box
      def initialize(contract_effective_date)
        super(BoxTypes::STARTER, contract_effective_date)
      end
    end
  end
end