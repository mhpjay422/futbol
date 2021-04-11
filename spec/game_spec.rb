require '../lib/stat_tracker.rb'
require '../lib/game.rb'
require 'csv'
require 'pry'

describe Game do 

  describe 'new' do 
    context 'given a row of csv data' do 
      it 'returns a Game object' do 
        @csvrow = nil
        CSV.foreach('../data/games.csv', headers:true, header_converters: :symbol) do |row|
          @csvrow = row
          break
        end 
        
        expect(Game.new(@csvrow).class).to eq(Game)
      end
    end
  end

  describe '::load_games' do 
    context 'given a file path to the csv data' do 
      it 'returns an array of Game objects' do 

        expect(Game.load_games('../data/games.csv').class).to eq(Array)
        expect(Game.load_games('../data/games.csv').all? {|game| game.class == Game}).to eq(true)
      end
    end
  end

end