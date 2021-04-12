require '../lib/stat_tracker'
require '../lib/game'
require '../lib/team'
require '../lib/game_team'


describe StatTracker do 
  before do
    game_path = '../data/games.csv'
    team_path = '../data/teams.csv'
    game_teams_path = '../data/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new(@locations)

    @all_games = @stat_tracker.game_collection
    @all_teams = @stat_tracker.team_collection
    @all_game_teams = @stat_tracker.single_team_stats_specific_game_collection
  end
  
  describe '.new' do 
    context 'given a locations hash' do 
      it 'has instance variables that equal file paths to corresponding csv data' do 

        expect(StatTracker.new(@locations).games).to eq('../data/games.csv')
        expect(StatTracker.new(@locations).teams).to eq('../data/teams.csv')
        expect(StatTracker.new(@locations).game_teams).to eq('../data/game_teams.csv')
      end
    end
  end

  describe 'Game Statistics' do 

    describe 'highest total score' do 
      context 'given an array of game stats' do 
        it 'returns the highest score' do 
          expect(@stat_tracker.highest_total_score(@all_games)).to eq(11)
        end
      end
    end

    describe 'lowest total score' do 
      context 'given an array of game stats' do 
        it 'returns the lowest combined score from all games' do 
          expect(@stat_tracker.lowest_total_score(@all_games)).to eq(0)
        end
      end
    end



  end


end