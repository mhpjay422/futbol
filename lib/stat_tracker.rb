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
    Team.load_teams(@teams)
  end

  def single_team_stats_specific_game_collection 
    GameTeam.load_game_team(@games_teams)
  end

#
# GAME STATISTICS  
#

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
    home_wins / games.length.to_f * 100.round(2)
  end
  
  def percentage_visitor_wins(games)
    visitor_wins = games.reduce(0) {|total, game| total += 1 if game.away_goals > game.home_goals; total }
    visitor_wins / games.length.to_f * 100.round(2)
  end
  
  def percentage_ties(home_percentage, away_percentage)
    100 - (home_percentage + away_percentage).to_f.round(2)
  end
  
  def count_of_games_by_season(games)
    hash = {}
    games.each {|game| hash[game.season] ? hash[game.season] += 1 : hash[game.season] = 1}
    hash
  end
  
  def average_goals_per_game(games)
    total_goals = games.reduce(0) {|total, game| total += (game.away_goals + game.home_goals); total}
    total_goals / games.length.to_f.round(2)
  end
  
  def average_goals_by_season(games)
    hash = {}
    games.each do |game|
      season = game.season
      home_goals = game.home_goals
      away_goals = game.away_goals

      if hash[season]
        hash[season][0] += 1
        hash[season][1] += (home_goals + away_goals)
      else 
        hash[season] = [1, (home_goals + away_goals)]
      end
    end

    hash = hash.each {|game| hash[game[0]] = game[1][1] / game[1][0].to_f.round(2)}
  end

#
# LEAGUE STATISTICS
#

  def count_of_teams(game_stats)
    game_stats.map {|game| game.team_id}.uniq!.length
  end

  def total_games_and_points(game_stats, hoa=nil)
    totaled = game_stats.reduce({}) do |total, game|
      team_id  = game.team_id
      goals = game.goals

      if hoa == nil || game.HoA == hoa 
        if total[team_id] == nil
          total[team_id] = [1, goals]        
        else 
          games = total[team_id][0] + 1
          cumulative_goals = total[team_id][1] + goals

          total[team_id] = [games, cumulative_goals]
        end
      end  
      total
    end
  end

  def averaged(totaled)
    averaged = totaled.map do |team| 
      average = team[1][1] / team[1][0].to_f
      [team[0], average]
    end
  end

  def best_offense(game_stats)
    totaled = total_games_and_points(game_stats)  
        
    averaged = averaged(totaled)

    best_offense_id = averaged.max_by {|team| team[1]}[0]

    best_offense_team = self.team_collection.find {|team| team.team_id == best_offense_id}.team_name    

  end

  def worst_offense(game_stats)
    totaled = total_games_and_points(game_stats)
    averaged = averaged(totaled)
    worst_offense_id = averaged.max_by {|team| -team[1]}[0]
    worst_offense_team = self.team_collection.find {|team| team.team_id == worst_offense_id}.team_name 
  end

  def highest_scoring_visitor(game_stats)
    visitor_totals = total_games_and_points(game_stats, "away")
    averaged = averaged(visitor_totals)
    highest_scoring_visitor_id = averaged.max_by {|team| team[1]}[0]
    highest_scoring_visitor_team = self.team_collection.find {|team| team.team_id == highest_scoring_visitor_id}.team_name 
  end

  # def highest_scoring_home_team(game_stats)

  # end

  # def lowest_scoring_visitor(game_stats)

  # end

  # def lowest_scoring_home_team(game_stats)

  # end

#
# 
#

  def team_info(teams)
    hash = {}
    teams.each do |team| 
      teamhash = {}
      teamhash[:team_id] = team.team_id
      teamhash[:franchise_id] = team.franchise_id
      teamhash[:abbreviation] = team.abbreviation
      teamhash[:stadium] = team.stadium
      teamhash[:link] = team.link
      hash[team.team_name.gsub(/\s+/, "_").to_sym] = teamhash
    end
    hash
  end
  
  # def best_season

  # end

  # def worst_season

  # end

  # def average_win_percentage

  # end

  # def most_goals_scored

  # end

  # def fewest_goals_scored

  # end

  # def favorite_opponent

  # end

  # def rival

  # end



end
