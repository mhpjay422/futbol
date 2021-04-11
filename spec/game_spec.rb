require '../lib/stat_tracker.rb'
require '../lib/game.rb'
require 'pry'
require 'csv'

describe Game do 



  describe 'new' do 
    before :each do 
      @csvrow = nil
      CSV.foreach('../data/games.csv', headers:true, header_converters: :symbol) do |row|
        @csvrow = row
        break
      end 
    end

      context 'given a row of csv data' do 
        it 'returns a Game object' do 

          expect(Game.new(@csvrow).class).to eq(Game)
        end
    end
  end

  describe '::load_games' do 
    context 'given a file path to the csv data' do 
      it 'returns an array of game objects' do 

        expect(Game.load_games('../data/games.csv').class).to eq(Array)
      end
    end
  end

end