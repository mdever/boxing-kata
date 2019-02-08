module Boxing
  module Kata
    class CSVInputParser
      attr_accessor :input

      def initialize(input_stream)
        @input = input_stream.read
      end
    end
  end 
end
