json.array do
  @proficiency_templates do |tempate|
    json do
      json.id = template.id
      json.name = template.name
      json.attribute_name = template.attribute_name
    end
  end
end