class Race < ActiveRecord::Base
  has_many :perks
  
  def add_race
  end
  
  def remove_race
  end
  
end
