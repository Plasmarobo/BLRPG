#Parse CSV values in the prerequisites field
#Check for "Level" requirement
#Check for Skill Name
#Build proficiency seed
#output

require 'csv'
preq_regex = /prerequisites\:\s?\"?([\w\s\,*]*)\"?\)/

def put_req(output, sk_id, rtype, rname, rval)
  output << "Preqrequisite.create(skill_template_id: #{sk_id}, prereq_type: '#{rtype}', prereq_name: '#{rname}', value: #{rval})\n"
end

#At most one seed item per line
outfile = File.open("db/newseeds.rb", "w")
append_preqs = []
File.foreach("db/seeds.rb") do |line|
  if (id = /^(.*)\s?=\s?([A-Z]).*([A-Z]).*\.create.*$/.match(line)) == nil then
    pf = "ERR"
    /([A-Z][a-z]).*\.create.*$/.match(line) do |m|
      pf = m[1].downcase
    end
    /name:\s?\"([\w\s]*)\"/.match(line) do |m|
      id = "#{pf}_#{m[1].downcase.gsub(/\s+/, "")}"
      outfile << "#{id} = #{line}"
    end
  else
    outfile << line
  end
  if id != nil and id.size > 0
    pm = preq_regex.match(line)
    if (pm != nil and pm[1] != "nil")
      p pm[1]
      CSV.parse(pm[1]) do |row|
        row.each do |reference|
          if (level = /Level\s*(\d*)/.match(reference)) != nil
            put_req(append_preqs, id, "level", "level", level[1].to_i)
          else
            if reference != nil and reference != "nil"
              put_req(append_preqs, id, "skill", reference, "'#{reference}'")
            end
          end
        end
      end
    end
  end
end
append_preqs.each do |prereq|
  outfile << prereq
end