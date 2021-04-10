require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'


game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

all_games = stat_tracker.game_collection
all_teams = stat_tracker.team_collection
all_game_teams = stat_tracker.single_team_stats_specific_game_collection

puts highest_combined_score = stat_tracker.highest_total_score(all_games)
puts lowest_combined_score = stat_tracker.lowest_total_score(all_games)
puts percent_home_victory = stat_tracker.percentage_home_wins(all_games)
puts percent_visitor_victory = stat_tracker.percentage_visitor_wins(all_games)
puts percent_score_even = stat_tracker.percentage_ties(percent_home_victory, percent_visitor_victory)
puts num_games_per_season = stat_tracker.count_of_games_by_season(all_games)
puts avg_goals_game = stat_tracker.average_goals_per_game(all_games)
puts avg_goals_season = stat_tracker.average_goals_by_season(all_games)

puts num_teams = stat_tracker.count_of_teams(all_game_teams)
puts best_scoring_team = stat_tracker.best_offense(all_game_teams)
puts worst_scoring_team = stat_tracker.worst_offense(all_game_teams)
puts high_scoring_visitor = stat_tracker.highest_scoring_visitor(all_game_teams)
puts high_scoring_home_team = stat_tracker.highest_scoring_home_team(all_game_teams)
puts low_scoring_visitor = stat_tracker.lowest_scoring_visitor(all_game_teams)
puts low_scoring_home_team = stat_tracker.lowest_scoring_home_team(all_game_teams)

puts best_wins_coach = stat_tracker.winningest_coach(20122013, all_game_teams)
puts worst_wins_coach = stat_tracker.worst_coach(20132014, all_game_teams)
puts best_shot_ratio_team = stat_tracker.most_accurate_team(20132014, all_game_teams)
puts worst_shot_ratio_team = stat_tracker.least_accurate_team(20142015, all_game_teams)
puts most_team_tackles = stat_tracker.most_tackles(20122013, all_game_teams)
puts most_team_tackles = stat_tracker.most_tackles(20142015, all_game_teams)
puts least_team_tackles = stat_tracker.fewest_tackles(20122013, all_game_teams)
puts least_team_tackles = stat_tracker.fewest_tackles(20142015, all_game_teams)

puts info_team = stat_tracker.team_info(1)
puts best_season_for_team = stat_tracker.best_season(1)
puts worst_season_for_team = stat_tracker.worst_season(1)
puts worst_season_for_team = stat_tracker.average_win_percentage(6)
puts most_goals_for_team = stat_tracker.most_goals_scored(6)
puts most_goals_for_team = stat_tracker.fewest_goals_scored(9)
puts fav_opposing_team = stat_tracker.favorite_opponent(3)
puts rival_team = stat_tracker.rival(3)
