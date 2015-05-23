#Parse CSV values in the prerequisites field
#Check for "Level" requirement
#Check for Skill Name
#Build proficiency seed
#output

require 'csv'
preq_regex = /actions\:\s?\"?([\w\s\,*]*)\"?/
id_regex = /(mi_\S*)\s?=/

def put_req(output, mi_id, ms_id)
  output << "MinionSkillSet.create(minion_template_id: #{mi_id}.id, minion_skill_template_id: #{ms_id}.id)\n"
end

#At most one seed item per line
outfile = File.open("newseeds.rb", "w")
append_preqs = []
File.foreach("../db/seeds.rb") do |line|
  id = id_regex.match(line)
  if (id != nil)
    puts id[1]
    pm = preq_regex.match(line)
    if (pm != nil and pm[1] != "nil")
      p pm[1]
      CSV.parse(pm[1]) do |row|
        row.each do |reference|
          if reference != nil and reference != "nil" 
            put_req(append_preqs, id[1], "ms_" + reference.gsub(/\s+/, "").downcase)
          end
        end
      end
    end
  end
end
append_preqs.each do |prereq|
  outfile << prereq
end