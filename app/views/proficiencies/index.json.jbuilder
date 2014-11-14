json.array do
  @proficiencies do |prof|
    json do
      json.id = prof.id
      json.name = prof.name
      json.tier = prof.tier
      json.vault_hunter_id = prof.vault_hunter_id
    end
  end
end