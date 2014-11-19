# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#user = User.new(username: 'plasmarobo', email: 'plasmarobo@gmail.com', password: 'password', password_confirmation: 'password')
#user.skip_confirmation!
#user.save!

#Production Attributes
blk = AttributeTemplate.create(name: 'bulk', short: 'BLK')
fin = AttributeTemplate.create(name: 'finesse', short: 'FIN')
sir = AttributeTemplate.create(name: 'sirenity', short: 'SIN')
tec = AttributeTemplate.create(name: 'technomancy', short: 'TEC')
#Prereq types: attribute level skill
skill = SkillTemplate.create(name:'Digistruct Turret', skill_type:'Defining', duration: 3, cooldown: 5, description:'Digistructs in a battle turret (model dependent on corporate affiliation) that does damage to enemies. The turret attacks the nearest enemy with a pool of 5. It has a weapon damage of 1.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Assault Turret', skill_type:'Upgrade', duration: 3, cooldown: 5, description:'Digistructed turrets gain Rapid 3 and the attack pool increases by 1.')
Prerequsite.create(skill_template_id:skill.id, prereq_name:"technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Support Turret', skill_type:'Defining', duration: 0, cooldown: 0, description:'When a player begins their turn next to a Digistructed turret of your creation, they heal 1 wound.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Dual Wield', skill_type:'Active', duration: 3, cooldown: 5, description:'Choose two light weapons. You may make one attack with each weapon (2 attacks per turn) but you attack pools are halved.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Gunzerking', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'When using Dual Wield, you may select medium weapons in addition to light weapons.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'DeadEye', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'When using Dual Wield only halve the attack pool of your second attack.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 4)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)

skill = SkillTemplate.create(name:'Pickpocket', skill_type:'Passive', duration: 0, cooldown: 0, description:'When you make a melee attack against an enemy, you may choose to deal no damage and instead remove a light weapon or object on their person. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 6)

skill = SkillTemplate.create(name:'Rage', skill_type:'Defining', duration: 3, cooldown: 5, description:'When you use rage you take 1 less damage from all sources for the duration of the skill. Additionally your melee attack damage deals 1 point of damage for every hit scored against the enemy. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Volcanic Rage', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'Attacks made with Rage gain Fire 2')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 2)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Rage", prereq_type: "skill", value: 0)

skill = SkillTemplate.create(name:'Unstoppable', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'Attacks made with Rage deal 2 additional points of damage.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 4)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Rage", prereq_type: "skill", value: 0)

skill = SkillTemplate.create(name:'Unbreakable', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'While using rage you take 3 less damage from all sources for the duration of the skill instead of 1.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 5)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Rage", prereq_type: "skill", value: 3)

skill = SkillTemplate.create(name:'Punishing Strike', skill_type:'Basic', duration: 0, cooldown: 5, description:'When you declare a punishing strike, make a melee attack. Your attack deals no damage. If you score at least one hit, at the end of the attack phase your target takes damage equal to the amount they dealt to any member of your party.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Tackle', skill_type:'Basic', duration: 0, cooldown: 5, description:'You may make a basic melee attack against an enemy. This attack deals 5 extra damage. You and the target are both stunned until the end of the next action phase.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Bullrush', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'Using Tackle does not stun you.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "tackle", prereq_type: "skill", value: 3)

skill = SkillTemplate.create(name:'Hammerthrow', skill_type:'Basic', duration: 0, cooldown: 0, description:'When you make a melee attack against an enemy (limit of 50lbs per point of BLK) you may subtract up to three points of damage from the attack. You may throw the target 5ft for each point of damage subtracted in this way.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bulk", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Amplified', skill_type:'Basic', duration: 0, cooldown: 5, description:'You may choose to subtract a number of points from your current shield strength. For each point subtracted in this way, ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 5)

skill = SkillTemplate.create(name:'Phase Gaze', skill_type:'Basic', duration: 3, cooldown: 5, description:'You may use your action to mark a target. The target is marked for the duration of this skill. Attacks made against the marked target receive +2 to the attack pool.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 2)

skill = SkillTemplate.create(name:'Phase Pulse', skill_type:'Defining', duration: 0, cooldown: 3, description:'You can make an attack with a pool equal to 3 + [SIN]. A hit deals 1 Damage, and Stuns the target. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Phase Walk', skill_type:'Basic', duration: 3, cooldown: 5, description:'Character can become invisible for a short period of time. While a character is invisible they may move, but take no damage and can not take actions. Any ongoing effects are suspended (dealing no damage, but remaining at current count). At the end of the duration make an attack with pool 5, damage 2 against all enemies within 10 ft.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 3)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 4)

skill = SkillTemplate.create(name:'Stunning Grace', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'When you end phase walk, any enemy which takes damage from phase walk becomes Stunned.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Phase Walk", prereq_type: "skill", value: 0)

skill = SkillTemplate.create(name:'Phase Shift', skill_type:'Passive', duration: 0, cooldown: 0, description:'Player may add Sirenity to a check to interact with nearby Doors and Traps using their echo device.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 2)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 2)

skill = SkillTemplate.create(name:'Overload', skill_type:'Defining', duration: 3, cooldown: 3, description:'Weapon attacks deal 2 additional points of damage. Attack actions cannot be made during cooldown.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Headshot 1', skill_type:'Passive', duration: 0, cooldown: 0, description:'If a 6 is rolled on an Aim check, Deal 1 additional damage that ignores armor and deflect.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 2)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)

skill = SkillTemplate.create(name:'Attack Drone', skill_type:'Defining', duration: 3, cooldown: 5, description:'You can summon a drone that attack enemies')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Defense Drone', skill_type:'Defining', duration: 3, cooldown: 5, description:'You can summon a drone that will regenerate either your shields or your health')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Support Drone', skill_type:'Defining', duration: 3, cooldown: 5, description:'You can summon a drone that will mark enemies and buff your party. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Phase Lock', skill_type:'Basic', duration: 2, cooldown: 5, description:'Traps an enemy in a bubble of space-time, renders them stunned and helpless for a certain number of turns')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 5)

skill = SkillTemplate.create(name:'Bleeding Blade', skill_type:'Basic', duration: 3, cooldown: 5, description:'Your melee strike causes enemies to bleed, taking constant minor damage per turn. The first attack that hits after activating this skill imparts Bleed 3 to the target.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 4)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "bluk", prereq_type: "attribute", value: 2)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)

skill = SkillTemplate.create(name:'Penetrating Shot', skill_type:'Basic', duration: 0, cooldown: 5, description:'Make a Basic ranged attack. This attack ignores shields entirely. This skill applies only to non-rapid weapons, and applies only to the first attack made in a turn.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 4)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)

skill = SkillTemplate.create(name:'Cauterize', skill_type:'Basic', duration: 3, cooldown: 5, description:'You may use your action to make a basic attack against an ally. Ignore their shields. For every two hits scored they recover 1 wound. Round down. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 3)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 4)

skill = SkillTemplate.create(name:'Minion Strike', skill_type:'Defining', duration: 3, cooldown: 5, description:'You command a minion or pet to harrass targets that attack you. At the end of each action phase they attack with a pool of 4 against the nearest foe which made attacks against you, dealing 1 damage.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 1)

skill = SkillTemplate.create(name:'Minion Bounce', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'Your Minion targets up to two foes, in order nearest to you when using Minion Strike. You minion cannot target a single foe more than once per turn.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 2)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Minion Strike", prereq_type: "skill", value: 3)

skill = SkillTemplate.create(name:'Minion Chain', skill_type:'Upgrade', duration: 0, cooldown: 0, description:'Your Minion targets a number of foes equal to your Sirenity score, starting with the nearest and proceeding to the next nearest enemy. Your minion cannot target a single foe more than once per turn.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 5)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "Minion Bounce", prereq_type: "skill", value: 3)

skill = SkillTemplate.create(name:'Minon Mark', skill_type:'Defining', duration: 3, cooldown: 5, description:'You Minion marks a target for you. Actions taken against this target by your or your allies have 2 added to the attack pool.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "sirenity", prereq_type: "attribute", value: 1)

skill = SkillTemplate.create(name:'Hurry Up!', skill_type:'Basic', duration: 3, cooldown: 5, description:'Use your action to put pressure on an ally. The Rapid number of all allies attacks increases by 2. If the weapon was not rapid, it becomes Rapid 2.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 3)

skill = SkillTemplate.create(name:'Adreniline Boost', skill_type:'Basic', duration: 3, cooldown: 5, description:'You move an extra 15 ft per turn, and the Rapid number of your attacks increases by 1. If a weapon was not rapid, it becomes Rapid 2.')

skill = SkillTemplate.create(name:'Sneak Attack', skill_type:'Passive', duration: 0, cooldown: 5, description:'If an enemy is unaware of you (via an action, stealth proficiency, or luck) you attacks deal twice as much damage. Any enemies hit become aware of you at the end of the action phase.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Decoy', skill_type:'Defining', duration: 3, cooldown: 5, description:'You generate a decoy, a holographic image of yourself while you cloak. Enemies are considered unaware of you and target your decoy as if it was you.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Crippling Strike', skill_type:'Advanced', duration: 0, cooldown: 10, description:'Make a basic attack. This attack ignores shield. The attack deals twices as much damage, slows the enemy, and applies Bleed 5')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "finesse", prereq_type: "attribute", value: 4)
Prerequsite.create(skill_template_id:skill.id, prereq_name: "level", prereq_type: "level", value: 10)

skill = SkillTemplate.create(name:'Shield Boost', skill_type:'Basic', duration: 0, cooldown: 3, description:'You use your action to regenerate one point of current shield.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 4)

skill = SkillTemplate.create(name:'Kinetic Reflector', skill_type:'Basic', duration: 3, cooldown: 5, description:'You make not take move actions for the duration of this skill. All enemies who target you grant you a stack of Kinetic power. At the end of the duration, you make either make a ranged attack against a single target within 40 ft, or make an attack against as many targets as you have kinetics stacks within 10 ft. Each kinetic stack does 1 point of damage on a hit.')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 5)

skill = SkillTemplate.create(name:'Defibulating Round', skill_type:'Defining', duration: 0, cooldown: 5, description:'You may use your action to make a ranged attack against an ally. The attack deals no damage, but heals the target 1 wound, and removing the downed condition. ')
Prerequsite.create(skill_template_id:skill.id, prereq_name: "technomancy", prereq_type: "attribute", value: 3)

skill = SkillTemplate.create(name:'Aim', skill_type:'Free', duration: 0, cooldown: 0, description:'You can make a basic Ranged attack by rolling [FIN] + Weapon Accuracy. You may use this once per combat turn.')
skill = SkillTemplate.create(name:'Smash', skill_type:'Free', duration: 0, cooldown: 0, description:'You can make a basic Melee attack by rolling [BLK] + Weapon Accuracy. You may use this once per combat turn.')

#Production Proficiencies
ProficiencyTemplate.create(name:'First Aid', description:'You know how to patch folks up, regardless of whether or not you have a medical license.')
ProficiencyTemplate.create(name:'Athletics', description:'You can run, jump, swim, climb and wrestle a skag with your bare hands (assuming you and the skag were competing in a wresting match).')
ProficiencyTemplate.create(name:'Corporate Lore', description:'You know about the various corporations and manufacturers in the world, from Atlas to Tediore and everything in between.')
ProficiencyTemplate.create(name:'Nerd Lore', description:'You know about various aspects of nerd culture, whether your consider yourself a diehard or someone who just enjoys nerdy things.')
ProficiencyTemplate.create(name:'Eridian Lore', description:'You are an expert on Eridian Tech and History')
ProficiencyTemplate.create(name:'Investigation', description:'You can find the needle in the haystack. Every time.')
ProficiencyTemplate.create(name:'Spotting', description:'You can tell a bat from a bird at 1200 ft. Nothing escapes your eyes.')
ProficiencyTemplate.create(name:'Swift Hands', description:'Pulling objects out of pockets, or putting them back in, you\'re great at both.')
ProficiencyTemplate.create(name:'Acrobatics', description:'Flips, jumps, tumbles, you\'re a regular gymnast')
ProficiencyTemplate.create(name:'Medical Lore', description:'Disease, surgical equipment, toxins, you\'re all about it. (You most likely have a medical license, or had one at some point).')
ProficiencyTemplate.create(name:'Intimidation', description:'You just look imposing.')
ProficiencyTemplate.create(name:'Persuasion', description:'People just tend to do what you say.')
ProficiencyTemplate.create(name:'Naturalism', description:'You can survive in artic cold, fevered jungle, and burning desert')
ProficiencyTemplate.create(name:'Spacer', description:'You know about interplanetary craft and the hazards of space-travel')
ProficiencyTemplate.create(name:'Siren Lore', description:'You\'ve made special study of Sirens')
ProficiencyTemplate.create(name:'Biotech', description:'Bioengineering, biochemistry, you\'re great at using biology in place to technology')
ProficiencyTemplate.create(name:'Cybernetics', description:'You like to replace squishy things with hardware.')
ProficiencyTemplate.create(name:'Robotics', description:'Servos, sensors, and processors. You love all-metal monstrosities.')
ProficiencyTemplate.create(name:'Hardware Lore', description:'You\'re knowledgable about mechanical, electrical, and electronic devices.')
ProficiencyTemplate.create(name:'Hacking', description:'You can make computers do all sorts of things, most of them counter to their programming.')
ProficiencyTemplate.create(name:'Stealth', description:'You\'re an expert at misdirection, concealment, and silence.')
ProficiencyTemplate.create(name:'Biological Lore', description:'You know the natural. Animals, plants, etc.')
ProficiencyTemplate.create(name:'Endurance', description:'You\'re adept at powering through pain and discomfort')

#vh = VaultHunter.create(name: 'Angel', 
#                        user_id: user.id, 
#                        age: 23, 
#                        race: 'Human', 
#                        height:"5'2\"", 
#                        weight:"120lbs", 
#                        toughness:5, 
#                        wounds:2, 
#                        shield: 2, 
#                        current_shield: 1, 
#                        loot:'None to speak of', 
#                        money: 100, 
#                        level:1,
#                        current_skill_points: 0,
#                        current_proficiency_points: 0)
#blk.instance(vh, 1)
#fin.instance(vh, 2)
#sir.instance(vh, 5)
#tec.instance(vh, 3)

#atk_skill = ps.instance(vh)
#hack.instance(vh, 2)

#atk = Attack.create(vault_hunter_id:vh.id, name: 'Aim', pool: vh.attribute_instances.find_by_name('finesse').value + 2, dmg: 2, misc: 'Fire 1', skill_id: atk_skill.id)