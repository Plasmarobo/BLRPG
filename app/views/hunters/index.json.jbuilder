json.array do
  @vault_hunters.each do |hunter|
    json do
      json.(hunter, :created_at, :updated_at)
      json.name = hunter.name
      json.user_id = hunter.user_id
      json.age = hunter.age
      json.race = hunter.race
      json.height = hunter.height
      json.weight = hunter.weight
      json.toughness = hunter.toughness
      json.wounds = hunter.wounds
      json.shields = hunter.shield
      json.current_shield = hunter.current_shield
      json.loot = hunter.loot
      json.money = hunter.money
      json.level = hunter.level
      json.current_proficiency_points = hunter.current_proficiency_points
      json.current_skill_points = hunter.current_skill_points
    end
  end
end