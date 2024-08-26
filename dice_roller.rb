class DiceRoller
  def initialize(dice)
    @dice = dice
  end

  def roll
    values = @dice.map { |sides| rand(1..sides) }
    total = values.sum
    description = describe_dice

    RollResult.new(description, values, total)
  end

  private

  def describe_dice
    @dice.each_with_index.map do |sides, index|
      "#{index + 1} dice side is #{sides}"
    end.join(', ')
  end
end

class RollResult
  attr_reader :description, :values, :total

  def initialize(description, values, total)
    @description = description
    @values = values
    @total = total
  end

  def roll_details
    "Description: #{description}, Values: #{values.join(', ')}, Total: #{total}"
  end
end

def collect_dice_info
  num_of_dice = 0

  loop do
    puts "Enter the number of dice (must be greater than 0):"
    num_of_dice = gets.chomp.to_i
    break if num_of_dice > 0
    puts "Invalid input. Please enter a positive integer."
  end

  dice = []

  num_of_dice.times do |i|
    sides = 0

    loop do
      puts "Enter the number of sides for die #{i + 1} (must be greater than 0):"
      sides = gets.chomp.to_i
      break if sides > 0
      puts "Invalid input. Please enter a positive integer."
    end

    dice << sides
  end

  dice
end

def start_dice_roller
  dice = collect_dice_info
  roller = DiceRoller.new(dice)
  result = roller.roll
  puts result.roll_details
end

start_dice_roller
