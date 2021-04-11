require '../lib/stat_tracker.rb'

describe StatTracker do 
  before do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end
  
  describe '.new' do 
    context 'given a locations hash' do 
      it 'has instance variables that equal file paths to corresponding csv data' do 

        expect(StatTracker.new(@locations).games).to eq('./data/games.csv')
        expect(StatTracker.new(@locations).teams).to eq('./data/teams.csv')
        expect(StatTracker.new(@locations).game_teams).to eq('./data/game_teams.csv')
      end
    end
    
  end
end