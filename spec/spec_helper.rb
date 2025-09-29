require 'bundler/setup'
require 'rspec'
require_relative '../lib/greed/scorer'
require_relative '../lib/greed/dice'
require_relative '../lib/greed/player'
require_relative '../lib/greed/game'

RSpec.configure do |config|
  config.order = :random
  Kernel.srand config.seed
end
