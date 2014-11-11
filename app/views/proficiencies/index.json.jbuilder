json.array do
  @proficiencies do |prof|
    json do
      json.id = prof.id
      json.name = prof.name
      json.pool = prof.pool
      json.points = prof.points
      json.attribute_name = prof.attribute_name
      json.vault_hunter_id = prof.vault_hunter_id
    end
  end
end