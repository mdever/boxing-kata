require "spec_helper"

RSpec.describe Boxing::Kata do
  it "has a version number" do
    expect(Boxing::Kata::VERSION).not_to be nil
  end

  #All unit tests are found within different files. Attached CSV's show some e2e test fixtures.
  it "does something useful" do
    expect(true).to be(true) 
  end
end
