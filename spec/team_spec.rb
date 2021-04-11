require '../lib/stat_tracker.rb'
require '../lib/team.rb'
require 'csv'
require 'pry'

describe Team do 

  describe 'new' do 
    context 'given a row of csv data' do 
      it 'returns a team object' do 
        @csvrow = nil
        CSV.foreach('../data/teams.csv', headers:true, header_converters: :symbol) do |row|
          @csvrow = row
          break
        end 
        
        expect(Team.new(@csvrow).class).to eq(Team)
      end
    end
  end

  describe '::load_teams' do 
    context 'given a file path to the csv data' do 
      it 'returns an array of team objects' do 

        expect(Team.load_teams('../data/teams.csv').class).to eq(Array)
      end
    end
  end

end