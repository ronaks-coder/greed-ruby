RSpec.describe Greed::Player do
  it 'initializes with name and zero score' do
    p = Greed::Player.new('Alice')
    expect(p.name).to eq('Alice')
    expect(p.score).to eq(0)
    expect(p.in_game).to be false
  end
end
