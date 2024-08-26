require 'rspec'
require_relative '../dice_roller'

RSpec.describe DiceRoller do
  let(:dice) { [6, 8] }
  let(:roller) { DiceRoller.new(dice) }

  describe '#initialize' do
    it 'initializes with the correct dice array' do
      expect(roller.instance_variable_get(:@dice)).to eq(dice)
    end
  end

  describe '#roll' do
    it 'returns a RollResult object' do
      result = roller.roll
      expect(result).to be_a(RollResult)
    end

    it 'produces values within the correct range' do
      result = roller.roll
      expect(result.values[0]).to be_between(1, 6).inclusive
      expect(result.values[1]).to be_between(1, 8).inclusive
    end

    it 'calculates the correct total' do
      allow(roller).to receive(:rand).with(1..6).and_return(3)
      allow(roller).to receive(:rand).with(1..8).and_return(5)
      result = roller.roll
      expect(result.total).to eq(8)
    end

    it 'produces the correct description' do
      result = roller.roll
      expected_description = "1 dice side is 6, 2 dice side is 8"
      expect(result.description).to eq(expected_description)
    end
  end
end

RSpec.describe RollResult do
  let(:description) { "1 dice side is 6, 2 dice side is 8" }
  let(:values) { [3, 5] }
  let(:total) { 8 }
  let(:result) { RollResult.new(description, values, total) }

  describe '#initialize' do
    it 'sets the correct description, values, and total' do
      expect(result.description).to eq(description)
      expect(result.values).to eq(values)
      expect(result.total).to eq(total)
    end
  end

  describe '#roll_details' do
    it 'returns a string with the correct format' do
      expect(result.roll_details).to eq("Description: 1 dice side is 6, 2 dice side is 8, Values: 3, 5, Total: 8")
    end
  end
end
