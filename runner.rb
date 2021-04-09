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

# puts highest_combined_score = stat_tracker.highest_total_score(all_games)
# puts lowest_combined_score = stat_tracker.lowest_total_score(all_games)
# puts percent_home_victory = stat_tracker.percentage_home_wins(all_games)
# puts percent_visitor_victory = stat_tracker.percentage_visitor_wins(all_games)
# puts percent_score_even = stat_tracker.percentage_ties(percent_home_victory, percent_visitor_victory)
# puts num_games_per_season = stat_tracker.count_of_games_by_season(all_games)
# puts avg_goals_game = stat_tracker.average_goals_per_game(all_games)
# puts avg_goals_season = stat_tracker.average_goals_by_season(all_games)

# puts num_teams = stat_tracker.count_of_teams(all_game_teams)
# puts best_scoring_team = stat_tracker.best_offense(all_game_teams)
# puts worst_scoring_team = stat_tracker.worst_offense(all_game_teams)
# puts high_scoring_visitor = stat_tracker.highest_scoring_visitor(all_game_teams)
# puts high_scoring_home_team = stat_tracker.highest_scoring_home_team(all_game_teams)
# puts low_scoring_visitor = stat_tracker.lowest_scoring_visitor(all_game_teams)
puts low_scoring_home_team = stat_tracker.lowest_scoring_home_team(all_game_teams)

# puts info_team = stat_tracker.team_info(all_teams)