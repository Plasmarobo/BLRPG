
json.(@skill_template, :created_at, :updated_at)
json.id = @skill_template.id
json.name @skill_template.name
json.skill_type @skill_template.skill_type
json.cooldown @skill_template.cooldown
json.duration @skill_template.duration
json.description @skill_template.description