require 'pry'
require 'csv'

class StatTracker

  attr_reader :games, :teams, :games_teams
  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @games_teams = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def game_collection
    Game.load_games(@games)
  end

  def team_collection 

  end

  def single_team_stats_specific_game_collection 

  end

  def highest_total_score(games)    
    games.reduce(0) do |highest, game| 
      if game.away_goals + game.home_goals > highest
        highest = game.away_goals + game.home_goals
      end
      highest
    end
  end
  
  def lowest_total_score(games) 
    games.reduce(Float::INFINITY) do |lowest, game| 
      if game.away_goals + game.home_goals < lowest
        lowest = game.away_goals + game.home_goals
      end
      lowest
    end
  end
  
  def percentage_home_wins(games)
    home_wins = games.reduce(0) {|total, game| total += 1 if game.home_goals > game.away_goals; total }
    home_wins / games.length.to_f * 100
  end
  
  def percentage_visitor_wins(games)
    visitor_wins = games.reduce(0) {|total, game| total += 1 if game.away_goals > game.home_goals; total }
    visitor_wins / games.length.to_f * 100
  end
  
  def percentage_ties(games)
  
  end
  
  def count_of_games_by_season(games)
  
  end
  
  def average_goals_per_game(games)
  
  end
  
  def average_goals_by_season(games)
  
  end
end