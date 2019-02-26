require "boxing/kata/version"
require "boxing/kata/input_parser"
require "boxing/kata/formatter"

module Boxing
  module Kata
    def self.report
      unless has_input_file?
        puts "Usage: ruby ./bin/boxing-kata <spec/fixtures/family_preferences.csv"
      end

      do_main
    end

    def self.has_input_file?
      ARGV.length > 0
    end

    def self.do_main
      filename = ARGV[0]

      preferences = CSVInputParser.new(File.open(filename)).parse

      puts "Preferences loaded correctly\n" if preferences != nil

      formatter = BoxingFormatter.new(preferences)

      options = {
        "1" => lambda { puts formatter.format_colors },
        "2" => lambda { puts formatter.format_starter_boxes },
        "3" => lambda { puts formatter.format_refill_boxes },
        "4" => lambda { do_exit }
      }



      while true
        puts "Please select what you would like to do:"
        puts "1. Colors"
        puts "2. Starter Box"
        puts "3. Refill Box"
        puts "4. Exit"

        choice = STDIN.gets.chomp

        routine = options[choice]
        if routine == nil
          puts "Please select a number between 1 and 4"
          next
        end

        routine.call
      end
    
    end

    def self.do_exit
      puts "\n\nThank you for using boxing-kata\n\n"
      exit(0)
    end
  end
end