

class GameTeam
  extend Finder
  extend DataLoader

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
  
  def self.team_count
    GameTeam.all.map {|game| game.team_id}.uniq!.length
  end


  def self.total_games_and_points(game_stats, hoa=nil)
    totaled = game_stats.reduce({}) do |total, game|
      team_id  = game.team_id
      goals = game.goals

      if hoa == nil || game.HoA == hoa 
        if total[team_id] == nil
          total[team_id] = [1, goals]        
        else 
          games = total[team_id][0] + 1
          cumulative_goals = total[team_id][1] + goals
          total[team_id] = [games, cumulative_goals]
        end
      end  
      total
    end
  end

  def self.averaged(totaled)
    averaged = totaled.map do |team| 
      average = team[1][1] / team[1][0].to_f
      [team[0], average]
    end
  end

  def self.top_offense
    totaled = total_games_and_points(GameTeam.all)  
    averaged = averaged(totaled)
    best_offense_id = averaged.max_by {|team| team[1]}[0]
    best_offense_team = Team.find_id(best_offense_id).team_name
  end

end