json.array do
  @proficiency_templates do |tempate|
    json do
      json.id = template.id
      json.name = template.name
    end
  end
end