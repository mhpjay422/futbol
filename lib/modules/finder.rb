module Finder

  def find_id(id)
    
    # binding.pry;
    
    # do I need a case statement here?
    self.all.find {|obj| obj.team_id == id }
  end

  def all 
    load_data
  end 
end