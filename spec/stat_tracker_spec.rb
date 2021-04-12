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

    describe 'percent home victory' do 
      context 'given an array of game stats' do 
        it 'returns the percentage of home wins from all games' do 
          expect(@stat_tracker.percentage_home_wins(@all_games)).to eq(43.50221744389195)
        end
      end
    end

    describe 'percent visitor victory' do 
      context 'given an array of game stats' do 
        it 'returns the percentage of visitor wins from all games' do 
          expect(@stat_tracker.percentage_visitor_wins(@all_games)).to eq(36.110737804058594)
        end
      end
    end

    describe 'percent tie game' do 

      before do 
        @home_percent = @stat_tracker.percentage_home_wins(@all_games)
        @visitor_percent = @stat_tracker.percentage_visitor_wins(@all_games)
      end

      context 'given the home and visitor win percentage' do 
        it 'returns the percentage of games that end in a tie' do 

          expect(@stat_tracker.percentage_ties(@home_percent, @visitor_percent)).to eq(20.39)
        end
      end
    end

    describe 'number of games per season' do 
      context 'given an array of game stats' do 
        it 'returns a hash with season ids as keys and the corresponding number of games as values' do 

          expect(@stat_tracker.count_of_games_by_season(@all_games)).to eq(
            {20122013=>806, 20162017=>1317, 20142015=>1319, 20152016=>1321, 20132014=>1323, 20172018=>1355}
          )
        end
      end
    end

  end


end 