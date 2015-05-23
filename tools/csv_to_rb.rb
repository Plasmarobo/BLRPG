require 'csv'

class String
  def numeric?
    return true if self =~ /^\d+$/
    true if Float(self) rescue false
  end
end  

#Skills
#prefix = "SkillTemplate.create("
#postfix = ")\n"
#Proficiencies
varname_prefix = "mi_"
prefix = " = MinionTemplate.create("
postfix = ")\n"

output = File.open("result.rb", "w")
CSV.foreach("data.csv", headers: true) do |row|
  
  
  first = true
  row.each do |header, column|
    if not first
      output << ", "
    else
      output << varname_prefix
      output << column.downcase
      output << prefix
      first = false
    end
    if column != nil
      column = column.numeric? ? column : '"' + column + '"'
    else
      column = "nil"
    end
    output << "#{header.downcase}: #{column}"
  end
  output << postfix

 end
 
 output.close