class SkillTemplate < ActiveRecord::Base
    has_many :prerequsites
    def instance(vault_hunter)
        if vault_hunter.meets_prereq(self.prereq_type, self.prereq_name, self.value) then
          skill = Skill.create(vault_hunter_id:vault_hunter.id, skill_template_id:self.id)
        end
    end
end
