class SkillTemplate < ActiveRecord::Base
    has_many :prerequsites
    def instance(vault_hunter)
        result = false
        self.prerequsites.each do |req|
          result |=  vault_hunter.meets_prereq(req.prereq_type, req.prereq_name, req.value)
        end
        if result == true then
          skill = Skill.create(vault_hunter_id:vault_hunter.id, skill_template_id:self.id)
        end
        skill
    end
end
