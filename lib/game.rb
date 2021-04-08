class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id,:away_goals, :home_goals, :venue, :venue_link

  def initialize(data)
    @game_id = data[0]
    @season = data[1]
    @type = data[2]
    @date_time = data[3]
    @away_team_id = data[4]
    @home_team_id = data[5]
    @away_goals = data[6]
    @home_goals = data[7]
    @venue = data[8]
    @venue_link = data[9]
  end

  def self.load_games(data)
    arr = []
    CSV.foreach(data, headers:true, header_converters: :symbol) do |row|
      arr << Game.new(row)
    end
  end
end 