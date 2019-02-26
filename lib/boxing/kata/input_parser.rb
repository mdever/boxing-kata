require "boxing/kata/preferences"
require "boxing/kata/constants"

Colors ||= Boxing::Kata::Constants::Colors

module Boxing
  module Kata
    class CSVInputParser
      attr_accessor :input

      def initialize(input_stream)
        @input = input_stream.read
      end

      def parse
        @prefs = Preferences.new

        @input.each_line.with_index do |line, i|
          # Do not consider the header line
          next if i == 0
          next if line == "\n"
          
          fields = line.split(',', -1).each(&:strip!)

          validate(fields, i+1) # First line is headers

          # Based on the way we're splitting and the trailing 
          # comma in the input, we can get an extra "field" at the end.
          # Get rid of it
          if fields.length == 6 and fields[5].empty? then fields.pop end

          if fields.length != 5
            throw ParseError.new("Invalid number of fields in line #{i}: #{line}")
          end

          pref = Preference.new(fields[0], fields[1], fields[2], fields[3], fields[4].empty? ? nil : Date.parse(fields[4]))   
          @prefs << pref
        end

        @prefs
      end

      def validate(fields, i)
        if fields[0].empty?
          raise ParseError.new("Expected Integer at first field in line #{i}. Got nothing")
        end

        begin 
          fields[0] = Integer(fields[0])
        rescue ArgumentError => e
          raise ParseError.new("Expected Integer at first field in line #{i}. Found #{fields[0].class}")
        end

        if fields[1].empty?
          raise ParseError.new("Expected String at second field in line #{i}. Got nothing")
        end

        unless fields[1].is_a? String
          raise ParseError.new("Expected String at second field in line #{i}. Got #{fields[1].class}")
        end

        if fields[2].empty?
          raise ParseError.new("Expected String at third field in line #{i}. Got nothing")
        end

        unless Colors::AVAILABLE_COLORS.include? fields[2]
          raise ParseError.new("Expected to fine one of #{Colors::AVAILABLE_COLORS} in third field of line #{i}. Found #{fields[2]}")
        end

        if fields[3].empty?
          if fields[4].empty?
            raise ParseError.new("No primary_insured_id on a household member which is not PNI. Line #{i}")
          end
        else
          begin
            fields[3] = Integer(fields[3])
          rescue ArgumentError => e
            raise ParseError.new("Expected Integer on fourth field in line #{i}. Found #{fields[3].class}")
          end
        end

        if fields[4].empty?
          unless fields[3].is_a? Integer
            raise ParseError.new("Expected contract_effective_date in field 5 of line #{i}")
          end
        else
          begin
            Date.parse(fields[4])
          rescue ArgumentError
            raise ParseError.new("Expeted contract_effective_date to be in format \"YYYY-mm-dd\" in line #{i}. Got #{fields[4]}")
          end
        end
      end
    end

    class ParseError < RuntimeError

    end
  end 
end
