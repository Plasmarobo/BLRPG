class MinionTemplate < ActiveRecord::Base
  has_many :minions
  
  def size_description
    desc = "Error"
    case self.size
    when 0
      desc = "Teeny"
    when 1
      desc = "Small"
    when 2
      desc = "Medium"
    when 3
      desc = "Huge"
    when 4
      desc = "Giant"
    when 5
      desc = "Collossal"
    else
      desc = "Indescribable"
    end
    desc
  end
end
