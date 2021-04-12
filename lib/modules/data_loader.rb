require 'csv'

module DataLoader 
  def load_data 
    arr = []
    CSV.foreach(data_path, headers:true, header_converters: :symbol) do |row|
      arr << Game.new(row)
    end
    arr
  end

  def data_path 
    case 
    when self == Game 
      path = 'data/games.csv'
    when self == GameTeam
      path = 'data/game_teams.csv'
    when self == Team 
      path = 'data/teams.csv'
    end
    path  
  end
end