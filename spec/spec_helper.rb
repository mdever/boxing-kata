require "bundler/setup"
require "boxing/kata/boxing_kata"
require "boxing/kata/preferences"
require "boxing/kata/input_parser"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
