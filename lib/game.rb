class Game
  extend Finder
  extend DataLoader

  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id,:away_goals, :home_goals, :venue, :venue_link

  def initialize(data)
    @game_id = data[0].to_i
    @season = data[1].to_i
    @type = data[2]
    @date_time = Date.strptime(data[3], "%m/%d/%Y")
    @away_team_id = data[4].to_i
    @home_team_id = data[5].to_i
    @away_goals = data[6].to_i
    @home_goals = data[7].to_i
    @venue = data[8]
    @venue_link = data[9]
  end

  def self.sort_by_total_score
    sorted = Game.all.sort_by {|game| game.home_goals + game.away_goals}
  end

  def total_score 
    home_goals + away_goals
  end

end 