require "spec_helper"

Colors = Boxing::Kata::Constants::Colors

sample_file = "id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,green,2,,
6,Ben,green,2,,"

invalid_file = "id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,2,,
6,Ben,green,2,," 

describe Boxing::Kata::CSVInputParser do

  
  it "should read in the contents given an IO like object" do
    input_stream = StringIO.new(sample_file)
    parser = Boxing::Kata::CSVInputParser.new(input_stream)
    expect(parser.input).to be_instance_of(String)
  end

  it "should construct a Preferences object with a preference for each row" do
    input_stream = StringIO.new(sample_file)
    parser = Boxing::Kata::CSVInputParser.new(input_stream)

    prefs = parser.parse
    expect(prefs.length).to eq(5)
  end

  it "should throw ParseError when the color field is invalid" do
    input_stream = StringIO.new(invalid_file)
    parser = Boxing::Kata::CSVInputParser.new(input_stream)
    
    expect { parser.parse }.to raise_error(Boxing::Kata::ParseError)

  end
end