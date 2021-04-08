class StatTracker

  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @games_teams = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end