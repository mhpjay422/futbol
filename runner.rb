require './lib/stat_tracker'
require './lib/game'


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
highest_combined_score = stat_tracker.highest_total_score(all_games)
lowest_combined_score = stat_tracker.lowest_total_score(all_games)
percent_home_victory = stat_tracker.percentage_home_wins(all_games)
percent_visitor_victory = stat_tracker.percentage_visitor_wins(all_games)
percent_score_even = stat_tracker.percentage_ties(percent_home_victory, percent_visitor_victory)
num_games_per_season = stat_tracker.count_of_games_by_season(all_games)
goals_average = stat_tracker.average_goals_per_game(all_games)
puts goals_average