class GameTeam

  attr_reader :game_id, :team_id, :HoA, :result,:settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways
  def initialize(data)
    @game_id = data[0].to_i
    @team_id = data[1]
    @HoA = data[2]
    @result = data[3]
    @settled_in = data[4]
    @head_coach = data[5]
    @goals = data[6].to_i
    @shots = data[7].to_i
    @tackles = data[8].to_i
    @pim = data[9].to_i
    @powerPlayOpportunities = data[10].to_i
    @powerPlayGoals = data[11].to_i
    @faceOffWinPercentage = data[12].to_i.to_f
    @giveaways = data[13].to_i
    @takeaways = data[14].to_i
  end

  def self.load_game_team(data) 
    arr = []
    CSV.foreach(data, headers:true, header_converters: :symbol) do |row|
      arr << GameTeam.new(row)
    end
    arr
  end
end