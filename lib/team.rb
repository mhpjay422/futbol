class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
  def initialize(data)
    @team_id = data[0]
    @franchise_id = data[1]
    @team_name = data[2]
    @abbreviation = data[3]
    @stadium = data[4]
    @link = data[5]
  end

  def self.load_teams
    arr = []
    CSV.foreach('./data/teams.csv', headers:true, header_converters: :symbol) do |row|
      arr << Team.new(row)
    end
    arr
  end
  
end 