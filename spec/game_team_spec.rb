require '../lib/stat_tracker.rb'
require '../lib/game_team.rb'
require 'csv'
require 'pry'

describe GameTeam do 

  describe 'new' do 
    context 'given a row of csv data' do 
      it 'returns a Game_team object' do 
        @csvrow = nil
        CSV.foreach('../data/game_teams.csv', headers:true, header_converters: :symbol) do |row|
          @csvrow = row
          break
        end 
        
        expect(GameTeam.new(@csvrow).class).to eq(GameTeam)
      end
    end
  end

  describe '::load_game_team' do 
    context 'given a file path to the csv data' do 
      it 'returns an array of GameTeam objects' do 

        expect(GameTeam.load_game_team('../data/game_teams.csv').class).to eq(Array)
        expect(GameTeam.load_game_team('../data/game_teams.csv').all? {|team| team.class == GameTeam}).to eq(true)
      end
    end
  end

end