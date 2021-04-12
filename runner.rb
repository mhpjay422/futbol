require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'

stat_tracker = StatTracker.from_csv(locations)

#
# Game Statistics
#

puts highest_combined_score = stat_tracker.highest_total_score
puts lowest_combined_score = stat_tracker.lowest_total_score
puts percent_home_victory = stat_tracker.percentage_home_wins
puts percent_visitor_victory = stat_tracker.percentage_visitor_wins
puts percent_score_even = stat_tracker.percentage_ties
puts num_games_per_season = stat_tracker.count_of_games_by_season
puts avg_goals_game = stat_tracker.average_goals_per_game
puts avg_goals_season = stat_tracker.average_goals_by_season

#
# League Statistics
#

puts num_teams = stat_tracker.count_of_teams
puts best_scoring_team = stat_tracker.best_offense
puts worst_scoring_team = stat_tracker.worst_offense
puts high_scoring_visitor = stat_tracker.highest_scoring_visitor
puts high_scoring_home_team = stat_tracker.highest_scoring_home_team
puts low_scoring_visitor = stat_tracker.lowest_scoring_visitor
puts low_scoring_home_team = stat_tracker.lowest_scoring_home_team

#
# Season Statistics
#

puts best_wins_coach = stat_tracker.winningest_coach
puts worst_wins_coach = stat_tracker.worst_coach
puts best_shot_ratio_team = stat_tracker.most_accurate_team
puts worst_shot_ratio_team = stat_tracker.least_accurate_team
puts most_team_tackles = stat_tracker.most_tackles
puts least_team_tackles = stat_tracker.fewest_tackles

#
# Team Statistics
#

puts info_team = stat_tracker.team_info
puts best_season_for_team = stat_tracker.best_season
puts worst_season_for_team = stat_tracker.worst_season
puts avg_wins_percent = stat_tracker.average_win_percentage
puts most_goals_for_team = stat_tracker.most_goals_scored
puts least_goals_for_team = stat_tracker.fewest_goals_scored
puts fav_opposing_team = stat_tracker.favorite_opponent
puts rival_team = stat_tracker.rival
