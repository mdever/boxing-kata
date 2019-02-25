require "boxing/kata/version"
require "boxing/kata/input_parser"

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

      preferences.preferences.each do |pref|
        puts pref
      end

      puts "Preferences loaded correctly!"
      puts "Please select what you would like to do"
      puts "1. Colors"
      puts "2. Starter Box"
      puts "3. Refill Box"

      choice = gets.chomp

      puts "You selected #{choice}"
    end
  end
end