# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
AttributeTemplate.create(name: 'bulk', short: 'BLK')
AttributeTemplate.create(name: 'finesse', short: 'FIN')
AttributeTemplate.create(name: 'sirenity', short: 'SIN')
AttributeTemplate.create(name: 'technomancy', short: 'TEC')

ProficiencyTemplate.create(name: 'Hacking', attribute_name: 'Technomancy')
ProficiencyTemplate.create(name: 'Gunsmithing', attribute_name: 'Technomancy')
ProficiencyTemplate.create(name: 'Medica', attribute_name: 'Sirenity')
ProficiencyTemplate.create(name: 'Investigation', attribute_name: 'Sirenity')

SkillTemplate.create(name: 'Aim', skill_type:'Basic', cooldown:0, duration:0, description: 'Basic ranged attack, roll Accuracy + [FIN]')
SkillTemplate.create(name: 'Smash', skill_type:'Basic', cooldown:0, duration:0, description: 'Basic melee attack, roll Accuracy + [BLK]')
ps = SkillTemplate.create(name: 'PhaseShift', skill_type:'Defining', cooldown:0, duration:0, description: 'Hack doors and computers with an action')

Prerequsite.create(skill_template_id:ps.id, prereq_type:'attribute', prereq_name: 'finesse', value:2)