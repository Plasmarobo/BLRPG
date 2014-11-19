json.(@vault_hunter, :created_at, :updated_at)
json.id @vault_hunter.id
json.name @vault_hunter.name
json.user_id @vault_hunter.user_id
json.age @vault_hunter.age
json.race @vault_hunter.race
json.height @vault_hunter.height
json.weight @vault_hunter.weight
json.toughness @vault_hunter.toughness
json.wounds @vault_hunter.wounds
json.shields @vault_hunter.shield
json.current_shield = @vault_hunter.current_shield
json.loot @vault_hunter.loot
json.money @vault_hunter.money
json.level @vault_hunter.level
json.current_proficiency_points @vault_hunter.current_proficiency_points
json.current_skill_points @vault_hunter.current_skill_points
json.attacks @vault_hunter.attacks, template: 'attacks/show', as: :@attack
json.skills @vault_hunter.skills, template: 'skills/show', as: :@skills
json.proficiencies @vault_hunter.proficiencies, template: 'proficiencies/show', as: :@proficiency