RSpec.describe Greed::Scorer do
  it 'scores single ones and fives properly' do
    expect(Greed::Scorer.score([1,2,3,4,6])).to eq([100,1])
    expect(Greed::Scorer.score([5,2,3,4,6])).to eq([50,1])
  end

  it 'scores triplets' do
    expect(Greed::Scorer.score([2,2,2,3,4])).to eq([200,3])
    expect(Greed::Scorer.score([1,1,1,2,3])).to eq([1000,3])
  end

  it 'scores complex rolls' do
    expect(Greed::Scorer.score([1,1,1,5,5])).to eq([1100,5])
    expect(Greed::Scorer.score([1,5,1,2,4])).to eq([250,3])
  end

  it 'returns [0,0] for no scoring dice' do
    expect(Greed::Scorer.score([2,3,4,6,6])).to eq([0,0])
  end
end
