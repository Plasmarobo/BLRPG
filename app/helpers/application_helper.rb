module ApplicationHelper
  
  def listRowClass(index)
    ((index % 2) == 0) ? "vh_alt" : ""
  end
end
