json.(@attack, :created_at, :updated_at)
json.name @attack.name
json.pool @attack.pool
json.dmg @attack.dmg
json.misc @attack.misc
json.vault_hunter_id @attack.vault_hunter_id
json.skill_id @attack.skill_id