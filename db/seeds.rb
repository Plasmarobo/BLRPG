# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
blk = AttributeTemplate.create(name: 'bulk', short: 'BLK')
fin = AttributeTemplate.create(name: 'finesse', short: 'FIN')
sir = AttributeTemplate.create(name: 'sirenity', short: 'SIN')
tec = AttributeTemplate.create(name: 'technomancy', short: 'TEC')

hack = ProficiencyTemplate.create(name: 'Hacking', attribute_name: 'Technomancy')
ProficiencyTemplate.create(name: 'Gunsmithing', attribute_name: 'Technomancy')
ProficiencyTemplate.create(name: 'Medica', attribute_name: 'Sirenity')
ProficiencyTemplate.create(name: 'Investigation', attribute_name: 'Sirenity')

SkillTemplate.create(name: 'Aim', skill_type:'Basic', cooldown:0, duration:0, description: 'Basic ranged attack, roll Accuracy + [FIN]')
SkillTemplate.create(name: 'Smash', skill_type:'Basic', cooldown:0, duration:0, description: 'Basic melee attack, roll Accuracy + [BLK]')
ps = SkillTemplate.create(name: 'PhaseShift', skill_type:'Defining', cooldown:0, duration:0, description: 'Hack doors and computers with an action')

Prerequsite.create(skill_template_id:ps.id, prereq_type:'attribute', prereq_name: 'finesse', value:2)



vh = VaultHunter.create(name: 'Angel', user_id: 0, age: 23, race: 'Human', height:5, weight:120, toughness:5, wounds:2, shield: 2, current_shield: 1, loot:'None to speak of', money: 0, level:1)
blk.instance(vh, 1)
fin.instance(vh, 2)
sir.instance(vh, 5)
tec.instance(vh, 3)

atk_skill = ps.instance(vh)
hack.instance(vh, 2)

atk = Attack.create(vault_hunter_id:vh.id, name: 'Aim', pool: vh.attributes.find_by_name('finesse').value + 2, dmg: 2, misc: 'Fire 1', skill_id: atk_skill.id)