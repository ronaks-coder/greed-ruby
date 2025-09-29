RSpec.describe Greed::Game do
  it 'can be created with players' do
    players = [Greed::Player.new('A'), Greed::Player.new('B')]
    g = Greed::Game.new(players)
    expect(g).to be_a(Greed::Game)
  end
end
