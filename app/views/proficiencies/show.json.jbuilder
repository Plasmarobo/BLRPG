json.(@proficiency, :created_at, :updated_at)
json.id = @proficiency.id
json.name = @proficiency.name
json.pool = @proficiency.pool
json.point = @proficiency.points
json.attribute_name = @proficiency.attribute_name
json.vault_hunter_id = @proficiency.vault_hunter_id
