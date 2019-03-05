require "Date"
require "spec_helper"

describe Boxing::Kata::Box do

  before(:each) do
    @box = Boxing::Kata::StarterBox.new(Date.new)
  end

  it 'should record the weight of the items added' do 
    brush1 = Boxing::Kata::Brush.new(Colors::BLUE)
    brush2 = Boxing::Kata::Brush.new(Colors::GREEN)
    head1 = Boxing::Kata::ReplacementHead.new(Colors::BLUE)
    head2 = Boxing::Kata::ReplacementHead.new(Colors::GREEN)
    paste = Boxing::Kata::Paste.new

    @box.add_brush(brush1)
    @box.add_brush(brush2)

    @box.add_replacement_head(head1)
    @box.add_replacement_head(head2)

    @box.add_paste(paste)

    expect(@box.weight).to be(27.6)
  end

  describe 'should assign the correct mail class' do
    
    it 'should be first when under 16oz' do
      @box.weight = 15

      expect(@box.mail_class).to eq('first')
    end

    it 'should be priority when equal to 16oz' do
      @box.weight = 16

      expect(@box.mail_class).to eq('priority')
    end

    it 'should be priority when greater than 16oz' do
      @box.weight = 20
      
      expect(@box.mail_class).to eq('priority')
    end
  end

  describe(Boxing::Kata::RefillBox) do 

    describe('refill dates') do

      it 'should space dates in increments of 90 days' do
        box = Boxing::Kata::RefillBox.new(Date.parse('2019-04-01'))
        
        dates = box.refill_dates

        last_date = dates.shift
        dates.reduce do |last_date, next_date|
          expect(next_date - last_date).to eq(Rational(90/1))
          
          next_date
        end
      end

      it 'should not leave a 90 gap before the end of the year' do
        box = Boxing::Kata::RefillBox.new(Date.parse('2019-04-01'))
        
        dates = box.refill_dates

        last_shipment = dates.last

        nye = Date.new(last_shipment.year, 12, 31)

        expect(nye - last_shipment).to be < Rational(90/1)
      end

      # Corner case for last shipment 89 days before NYE
      it 'should not overlap at the end of the year' do
        box = Boxing::Kata::RefillBox.new(Date.parse('2019-01-05'))
        
        dates = box.refill_dates
        
        expect(dates.length).to eq(4)

        last_shipment = dates.last
        expect(last_shipment).to eq(Date.new(2019, 12, 31))
      end
    end
  end
end
