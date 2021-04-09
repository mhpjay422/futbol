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
    high_score_vis_id = averaged.max_by {|team| team[1]}[0]
    high_score_vis_team = self.team_collection.find {|team| team.team_id == high_score_vis_id}.team_name 
  end

  def highest_scoring_home_team(game_stats)
    home_totals = total_games_and_points(game_stats, "home")
    averaged = averaged(home_totals)
    high_score_home_id = averaged.max_by {|team| team[1]}[0]
    high_score_home_team = self.team_collection.find {|team| team.team_id == high_score_home_id}.team_name 
  end

  def lowest_scoring_visitor(game_stats)
    visitor_totals = total_games_and_points(game_stats, "away")
    averaged = averaged(visitor_totals)
    low_score_vis_id = averaged.max_by {|team| -team[1]}[0]
    low_score_vis_team = self.team_collection.find {|team| team.team_id == low_score_vis_id}.team_name 
  end

  def lowest_scoring_home_team(game_stats)
    home_totals = total_games_and_points(game_stats, "home")
    averaged = averaged(home_totals)
    low_score_home_id = averaged.max_by {|team| -team[1]}[0]
    low_score_home_team = self.team_collection.find {|team| team.team_id == low_score_home_id}.team_name
  end

#
# Season Statistics
#

  def total_games_wins_by_coach(find_games_for_season, game_stats) 
    game_stats.reduce({}) do |total, game|
      head_coach = game.head_coach
      win_or_loss = game.result == 'WIN' ? 1 : 0

      if find_games_for_season.any? {|gm| game.game_id == gm.game_id }
        if total[head_coach] != nil
          wins = total[head_coach][0] + win_or_loss
          games = total[head_coach][1] + 1
          total[head_coach] = [wins, games]
        else
          total[head_coach] = [win_or_loss, 1]
        end
      end
      
      total
    end
  end

  def average_head_coaching_wins(total_wins_and_games)
    total_wins_and_games.map do |coach_data|
      coach = coach_data[0]
      wins = coach_data[1][0]
      games = coach_data[1][1]
      [coach, wins/games.to_f]
    end
  end

  def winningest_coach(season_id, game_stats)
    load_season_games = self.game_collection
    find_games_for_season = load_season_games.select{|game| game.season == season_id}
    total_wins_and_games = total_games_wins_by_coach(find_games_for_season, game_stats) 
    averaged = average_head_coaching_wins(total_wins_and_games)
    win_coach = averaged.max_by {|coach| coach[1]}
  end
  
  def worst_coach(season_id, game_stats)
    load_season_games = self.game_collection
    find_games_for_season = load_season_games.select{|game| game.season == season_id}
    total_wins_and_games = total_games_wins_by_coach(find_games_for_season, game_stats) 
    averaged = average_head_coaching_wins(total_wins_and_games)
    win_coach = averaged.max_by {|coach| -coach[1]}
  end

  def culmulative_shooting_stats_by_team(find_games_for_season, game_stats)
    game_stats.reduce({}) do |total, game|
      team_id = game.team_id
      shots = game.shots
      goals = game.goals


      if find_games_for_season.any? {|gm| game.game_id == gm.game_id }
        if total[team_id] != nil
          total_goals = total[team_id][0] + goals
          total_shots = total[team_id][1] + shots
          total[team_id] = [total_goals, total_shots]
        else
          total[team_id] = [goals, shots]
        end
      end
      
      total
    end
  end

  def average_shooting_stats(total_shooting_stats)
    total_shooting_stats.map do |data|
      team = data[0]
      goals = data[1][0]
      shots = data[1][1]
      [team, goals/shots.to_f]
    end
  end

  def get_avg_shooting_stats_by_team(season_id, game_stats)
    load_season_games = self.game_collection
    find_games_for_season = load_season_games.select{|game| game.season == season_id}
    total_shooting_stats = culmulative_shooting_stats_by_team(find_games_for_season, game_stats)
    averaged = average_shooting_stats(total_shooting_stats)
  end
  
  def most_accurate_team(season_id, game_stats)
    averaged = get_avg_shooting_stats_by_team(season_id, game_stats)
    best_shooting_team_id = averaged.max_by {|team| team[1]}[0]
    best_shooting_team = self.team_collection.find {|team| team.team_id == best_shooting_team_id}.team_name
  end
  
  def least_accurate_team(season_id, game_stats)
    averaged = get_avg_shooting_stats_by_team(season_id, game_stats)
    best_shooting_team_id = averaged.max_by {|team| -team[1]}[0]
    best_shooting_team = self.team_collection.find {|team| team.team_id == best_shooting_team_id}.team_name
  end

  def culmulative_tackles_by_team_season(find_games_for_season, game_stats)
    game_stats.reduce({}) do |total, game|
      team_id = game.team_id
      tackles = game.tackles

      if find_games_for_season.any? {|gm| game.game_id == gm.game_id }
        if total[team_id] != nil
          total[team_id] = total[team_id] + tackles
        else
          total[team_id] = tackles
        end
      end
      
      total
    end
  end

  def most_tackles(season_id, game_stats)
    load_season_games = self.game_collection
    find_games_for_season = load_season_games.select{|game| game.season == season_id}
    count_tackles = culmulative_tackles_by_team_season(find_games_for_season, game_stats)
    most_tackles_id = count_tackles.max_by {|team| team[1]}[0]
    self.team_collection.find {|team| team.team_id == most_tackles_id}.team_name
  end
  
  def fewest_tackles(season_id, game_stats)
    load_season_games = self.game_collection
    find_games_for_season = load_season_games.select{|game| game.season == season_id}
    count_tackles = culmulative_tackles_by_team_season(find_games_for_season, game_stats)
    least_tackles_id = count_tackles.max_by {|team| -team[1]}[0]
    self.team_collection.find {|team| team.team_id == least_tackles_id}.team_name
  end
  

#
# Team Statistics
#



  def team_info(team_id)
    load_teams = self.team_collection
    team = load_teams.find {|team| team.team_id.to_i == team_id}
    teamhash = {}

    teamhash[:team_id] = team.team_id
    teamhash[:franchise_id] = team.franchise_id
    teamhash[:abbreviation] = team.abbreviation
    teamhash[:stadium] = team.stadium
    teamhash[:link] = team.link    
    teamhash[team.team_name.gsub(/\s+/, "_").to_sym] = team.team_name

    teamhash
  end
  
  def best_season(team_id)

  end

  # def worst_season(team_id)

  # end

  # def average_win_percentage(team_id)

  # end

  # def most_goals_scored(team_id)

  # end

  # def fewest_goals_scored(team_id)

  # end

  # def favorite_opponent(team_id)

  # end

  # def rival(team_id)

  # end



end
