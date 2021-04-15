class Game
  extend Finder
  extend DataLoader

  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(data)
    @game_id = data[0].to_i
    @season = data[1]
    @type = data[2]
    @date_time = data[3]
    # @date_time = Date.strptime(data[3], "%m/%d/%Y")
    @away_team_id = data[4].to_i
    @home_team_id = data[5].to_i
    @away_goals = data[6].to_i
    @home_goals = data[7].to_i
    @venue = data[8]
    @venue_link = data[9]
  end

  def self.sort_by_total_score
    Game.all.sort_by {|game| game.home_goals + game.away_goals}
  end


  def total_score 
    home_goals + away_goals
  end

  def winner 
    return nil if home_goals == away_goals
    return self.home_team_id if home_goals > away_goals
    return self.away_team_id if away_goals > home_goals
  end

  def loser
    return nil if home_goals == away_goals
    return away_team if away_goals < home_goals
    return home_team if home_goals < away_goals
  end

  def away_team  
    self.away_team_id
  end

  def home_team 
    # binding.pry;
    self.home_team_id
  end

  def self.where(objective, target)
    Game.all.select do |game| 
       target == :nil ? game.send(objective) == nil : game.send(objective) == game.send(target)
       # send is a method that invokes its param (which is the name of a method)
       # target eval to nil is testing if the game result ended in a tie
       # if so, finds games where result is nil ( tie )
       # otherwise eval calls objective and target and brings back results that are equal
    end
  end

  def self.num_games_by_season
    hash = {}
    Game.all.each {|game| hash[game.season] ? hash[game.season] += 1 : hash[game.season] = 1}
    hash
  end

  def self.avg_goals_per_season
    total_goals = Game.all.reduce(0) {|total, game| total += (game.away_goals + game.home_goals); total}
    (total_goals / Game.all.length.to_f).round(2)
  end


end 