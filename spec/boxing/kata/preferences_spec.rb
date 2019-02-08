require "spec_helper"

Colors = Boxing::Kata::Constants::Colors

sample_file = "id,name,brush_color,primary_insured_id,contract_effective_date
2,Anakin,blue,,2018-01-01
3,Padme,pink,2,,
4,Luke,blue,2,,
5,Leia,green,2,,
6,Ben,green,2,,"

RSpec.describe Boxing::Kata::Preferences do
  before(:each) do 
    @preferences = Boxing::Kata::Preferences.new

    @preference1 = Boxing::Kata::Preference.new(2, "Anakin", "blue", nil, "2018-01-01")
    @preference2 = Boxing::Kata::Preference.new(3, "Padme", "pink", 2)
    @preference3 = Boxing::Kata::Preference.new(4, "Luke", "blue", 2)
    @preference4 = Boxing::Kata::Preference.new(5, "Leia", "green", 2)
    @preference5 = Boxing::Kata::Preference.new(6, "Ben", "green", 2)
    
    @preferences << @preference1 \
                 << @preference2 \
                 << @preference3 \
                 << @preference4 \
                 << @preference5
    
  end
  it "should correctly count colors given the sample file" do
    colors = @preferences.color_count

    expect(colors[Colors::BLUE.to_sym]).to  eq(2)
    expect(colors[Colors::GREEN.to_sym]).to eq(2)
    expect(colors[Colors::PINK.to_sym]).to  eq(1)
  end
end
