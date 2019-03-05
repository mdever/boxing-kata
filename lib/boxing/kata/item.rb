module Boxing
  module Kata
    class BoxItem
      attr_accessor :type, :weight

      def initialize(type, weight)
        @type = type
        @weight = weight
      end
    end
  end
end
