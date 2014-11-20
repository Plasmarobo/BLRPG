json.(@attack, :created_at, :updated_at)
json.name @attack.name
json.pool @attack.pool
json.dmg @attack.dmg
json.base_pool @attack.base_pool
json.attribute_instance_id @attack.attribute_instance_id
json.misc_pool @attack.misc_pool
json.misc @attack.misc
json.vault_hunter_id @attack.vault_hunter_id
json.skill_id @attack.skill_id