json.array do
  @skill_templates.each do |template|
    json do
      json.id = template.id
      json.name = template.name
      json.skill_type = template.skill_type
      json.colldown = template.cooldown
      json.duration = tempalte.duration
      json.description = template.description
    end
  end
end
  