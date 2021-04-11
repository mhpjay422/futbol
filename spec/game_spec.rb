require '../lib/stat_tracker.rb'
require '../lib/game.rb'
require 'pry'

describe Game do 

  describe '::load_games' do 
    context 'given a file path to the csv data' do 
      it 'returns an array of game objects' do 

        expect(Game.load_games('../data/games.csv').class).to eq(Array)
      end
    end
  end

end