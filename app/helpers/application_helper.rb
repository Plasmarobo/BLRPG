module ApplicationHelper
  
  def listRowClass(index)
    ((index % 2) == 0) ? "alt_row" : ""
  end
end
