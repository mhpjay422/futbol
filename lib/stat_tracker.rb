require_relative './modules/finder'
require_relative './modules/data_loader.rb'
require_relative './stat_tracker'
require_relative './game'
require_relative './team'
require_relative './game_team'
require 'pry'



class StatTracker

  def self.from_csv(locations)
    @track = StatTracker.new
  end

  def highest_total_score
    sorted_scores = Game.sort_by_total_score
    highest = sorted_scores.last.total_score
    # game_collection.reduce(0) do |highest, game| 
    #   if game.away_goals + game.home_goals > highest
    #     highest = game.away_goals + game.home_goals
    #   end
    #   highest
    # end
  end

  def lowest_total_score
    sorted_scores = Game.sort_by_total_score
    lowest = sorted_scores.first.total_score
    # games.reduce(Float::INFINITY) do |lowest, game| 
    #   if game.away_goals + game.home_goals < lowest
    #     lowest = game.away_goals + game.home_goals
    #   end
    #   lowest
    # end
  end

  def calculate_percentage(wins)
    percentage = wins / Game.all.length.to_f
    percentage.round(2)
  end
  
  def percentage_home_wins
    num_home_wins = Game.where(:winner, :home_team).count
    calculate_percentage(num_home_wins)

    # home_wins = games.reduce(0) {|total, game| total += 1 if game.home_goals > game.away_goals; total }
    # home_wins / games.length.to_f * 100.round(2)
  end
  
  def percentage_visitor_wins
    num_visitor_wins = Game.where(:winner, :away_team).count
    calculate_percentage(num_visitor_wins)

    # visitor_wins = games.reduce(0) {|total, game| total += 1 if game.away_goals > game.home_goals; total }
    # visitor_wins / games.length.to_f * 100.round(2)
  end
  
  def percentage_ties
    total_wins = percentage_home_wins + percentage_visitor_wins
    win_p = (100 - (total_wins * 100).round().to_f) / 100

    # 100 - (home_percentage + away_percentage).to_f.round(2)
  end
  
  def count_of_games_by_season
    Game.num_games_by_season
    
    # hash = {}
    # games.each {|game| hash[game.season] ? hash[game.season] += 1 : hash[game.season] = 1}
    # hash
  end
  
  def average_goals_per_game
    Game.avg_goals_per_season

    # total_goals = games.reduce(0) {|total, game| total += (game.away_goals + game.home_goals); total}
    # total_goals / games.length.to_f.round(2)
  end
  
  def average_goals_by_season
    Game.avg_goals_by_season
    
    # hash = {}
    # games.each do |game|
    #   season = game.season
    #   home_goals = game.home_goals
    #   away_goals = game.away_goals

    #   if hash[season]
    #     hash[season][0] += 1
    #     hash[season][1] += (home_goals + away_goals)
    #   else 
    #     hash[season] = [1, (home_goals + away_goals)]
    #   end
    # end

    # hash = hash.each {|game| hash[game[0]] = game[1][1] / game[1][0].to_f.round(2)}
  end

# #
# # LEAGUE STATISTICS
# #

  def count_of_teams
    GameTeam.team_count
  end

  def best_offense
    GameTeam.top_offense
  end

  def worst_offense
    GameTeam.bottom_offense
  end

  def highest_scoring_visitor
    GameTeam.high_scoring_visitor
  end

  def highest_scoring_home_team
    GameTeam.high_scoring_home_team
  end

  def lowest_scoring_visitor
    GameTeam.low_scoring_visitor
  end

  def lowest_scoring_home_team
    GameTeam.low_scoring_home_team
  end

# #
# # Season Statistics
# #

  def winningest_coach(season_id)
    seasons = Game.find_seasons_for_team(season_id)
    GameTeam.most_wins_coach(seasons)
  end
  
  def worst_coach(season_id)
    seasons = Game.find_seasons_for_team(season_id)
    GameTeam.least_wins_coach(seasons)
  end

  # def culmulative_shooting_stats_by_team(find_seasons_for_team, game_stats)
  #   game_stats.reduce({}) do |total, game|
  #     team_id = game.team_id
  #     shots = game.shots
  #     goals = game.goals


  #     if find_seasons_for_team.any? {|gm| game.game_id == gm.game_id }
  #       if total[team_id] != nil
  #         total_goals = total[team_id][0] + goals
  #         total_shots = total[team_id][1] + shots
  #         total[team_id] = [total_goals, total_shots]
  #       else
  #         total[team_id] = [goals, shots]
  #       end
  #     end
      
  #     total
  #   end
  # end

  # def average_shooting_stats(total_shooting_stats)
  #   total_shooting_stats.map do |data|
  #     team = data[0]
  #     goals = data[1][0]
  #     shots = data[1][1]
  #     [team, goals/shots.to_f]
  #   end
  # end

  # def get_avg_shooting_stats_by_team(season_id, game_stats)
  #   load_season_games = self.game_collection
  #   find_seasons_for_team = load_season_games.select{|game| game.season == season_id}
  #   total_shooting_stats = culmulative_shooting_stats_by_team(find_seasons_for_team, game_stats)
  #   averaged = average_shooting_stats(total_shooting_stats)
  # end
  
  def most_accurate_team(season_id)
    seasons = Game.find_seasons_for_team(season_id)
    GameTeam.best_ratio_team(seasons)
    # averaged = get_avg_shooting_stats_by_team(season_id, game_stats)
    # best_shooting_team_id = averaged.max_by {|team| team[1]}[0]
    # best_shooting_team = self.team_collection.find {|team| team.team_id == best_shooting_team_id}.team_name
  end
  
#   def least_accurate_team(season_id, game_stats)
#     averaged = get_avg_shooting_stats_by_team(season_id, game_stats)
#     best_shooting_team_id = averaged.max_by {|team| -team[1]}[0]
#     best_shooting_team = self.team_collection.find {|team| team.team_id == best_shooting_team_id}.team_name
#   end

#   def culmulative_tackles_by_team_season(find_seasons_for_team, game_stats)
#     game_stats.reduce({}) do |total, game|
#       team_id = game.team_id
#       tackles = game.tackles

#       if find_seasons_for_team.any? {|gm| game.game_id == gm.game_id }
#         if total[team_id] != nil
#           total[team_id] = total[team_id] + tackles
#         else
#           total[team_id] = tackles
#         end
#       end
      
#       total
#     end
#   end

#   def most_tackles(season_id, game_stats)
#     load_season_games = self.game_collection
#     find_seasons_for_team = load_season_games.select{|game| game.season == season_id}
#     count_tackles = culmulative_tackles_by_team_season(find_seasons_for_team, game_stats)
#     most_tackles_id = count_tackles.max_by {|team| team[1]}[0]
#     self.team_collection.find {|team| team.team_id == most_tackles_id}.team_name
#   end
  
#   def fewest_tackles(season_id, game_stats)
#     load_season_games = self.game_collection
#     find_seasons_for_team = load_season_games.select{|game| game.season == season_id}
#     count_tackles = culmulative_tackles_by_team_season(find_seasons_for_team, game_stats)
#     least_tackles_id = count_tackles.max_by {|team| -team[1]}[0]
#     self.team_collection.find {|team| team.team_id == least_tackles_id}.team_name
#   end
  

# #
# # Team Statistics
# #


#   def team_info(team_id)
#     load_teams = self.team_collection
#     team = load_teams.find {|team| team.team_id.to_i == team_id}
#     teamhash = {}

#     teamhash[:team_id] = team.team_id
#     teamhash[:franchise_id] = team.franchise_id
#     teamhash[:abbreviation] = team.abbreviation
#     teamhash[:stadium] = team.stadium
#     teamhash[:link] = team.link    
#     teamhash[team.team_name.gsub(/\s+/, "_").to_sym] = team.team_name

#     teamhash
#   end

#   def team_game_data(team_id, load_games)    
#     load_games.reduce({}) do |total, game| 
#       win_or_loss = game.result == 'WIN' ? 1 : 0
#       season = game.game_id.to_s[0..3]
      
#       if game.team_id == team_id.to_s
#         if total[season] == nil
#           total[season] = [win_or_loss,1]
#         else 
#           wins = total[season][0] + win_or_loss
#           games = total[season][1] + 1
#           total[season] = [wins, games]
#         end
#       end    
#       total   
#     end
#   end

#   def average_team_win_loss(find_seasons_for_team)
#     find_seasons_for_team.map do |season| 
#       [season[0], season[1][0] / season[1][1].to_f]
#     end
#   end
  
#   def best_season(team_id)
#     load_games = self.single_team_stats_specific_game_collection
#     find_seasons_for_team = team_game_data(team_id, load_games)
#     averaged = average_team_win_loss(find_seasons_for_team)
#     best_season = averaged.max_by {|season| season[1]}[0]
#   end

#   def worst_season(team_id)
#     load_games = self.single_team_stats_specific_game_collection
#     find_seasons_for_team = team_game_data(team_id, load_games)
#     averaged = average_team_win_loss(find_seasons_for_team)
#     worst_season = averaged.max_by {|season| -season[1]}[0]
#   end

#   def average_win_percentage(team_id)
#     load_games = self.single_team_stats_specific_game_collection

#     totaled = load_games.reduce([0,0]) do |total, game| 
#       win_or_loss = game.result == 'WIN' ? 1 : 0
#       wins = total[0] + win_or_loss
#       games = total[1] + 1
      
#       game.team_id == team_id.to_s ? total = [wins, games] : total
#     end

#     total_avg = totaled[0] / totaled[1].to_f * 100
#   end

#   def most_goals_scored(team_id)
#     load_games = self.single_team_stats_specific_game_collection
#     load_games.reduce(0) do |total, game| 
      
#       total = game.goals if game.team_id == team_id.to_s && game.goals > total
#       total
#     end
#   end

#   def fewest_goals_scored(team_id)
#     load_games = self.single_team_stats_specific_game_collection
#     load_games.reduce(Float::INFINITY) do |total, game| 
      
#       total = game.goals if game.team_id == team_id.to_s && game.goals < total
#       total
#     end
#   end

#   def win_loss_vs_opponents(team_id, load_games)
#     load_games.reduce({}) do |total, game| 
#       home_team_id = game.home_team_id
#       away_team_id = game.away_team_id
#       is_team_home = home_team_id == team_id ? true  : false
#       did_home_win = game.home_goals > game.away_goals ? true : false
#       did_team_win = is_team_home == did_home_win
#       opponent_id = is_team_home ? away_team_id : home_team_id
#       win_or_loss = did_team_win ? 1 : 0
      
#       if home_team_id == team_id || away_team_id == team_id

#         if total[opponent_id] == nil
#           total[opponent_id] = [win_or_loss,1]
#         else 
#           wins = total[opponent_id][0] + win_or_loss
#           games = total[opponent_id][1] + 1
#           total[opponent_id] = [wins, games]
#         end
#       end

#       total   
#     end
#   end

#   def favorite_opponent(team_id)
#     load_games = self.game_collection
#     opposing_win_data = win_loss_vs_opponents(team_id, load_games)
#     best_win_opponent_id = opposing_win_data.max_by {|oppo| oppo[1][0] / oppo[1][1].to_f}[0]
#     self.team_collection.find {|team| team.team_id.to_i == best_win_opponent_id}.team_name
#   end

#   def rival(team_id)
#     load_games = self.game_collection
#     opposing_win_data = win_loss_vs_opponents(team_id, load_games)
#     worst_win_opponent_id = opposing_win_data.max_by {|oppo| -(oppo[1][0] / oppo[1][1].to_f)}[0]
#     self.team_collection.find {|team| team.team_id.to_i == worst_win_opponent_id}.team_name
#   end


end
