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
highest_score = stat_tracker.highest_total_score(all_games)