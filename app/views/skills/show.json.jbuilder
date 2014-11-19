json.(@skill, :created_at, :updated_at)
json.id @skill.id
json.name @skill.skill_template.name
json.skill_template_id @skill.skill_template_id
json.vault_hunter_id @skill.vault_hunter_id