RSpec.describe Greed::Dice do
  it 'rolls the correct number of dice in range 1..6' do
    rolls = Greed::Dice.roll(5)
    expect(rolls.size).to eq(5)
    expect(rolls).to all(be_between(1,6))
  end
end
