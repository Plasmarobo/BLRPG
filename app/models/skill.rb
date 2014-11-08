class Skill < ActiveRecord::Base
    belongs_to :vault_hunter
    belongs_to :skill_template
    
    def name
      self.skill_template.name
    end

    def type
      self.skill_template.type
    end

    def cooldown
      self.skill_template.cooldown
    end

    def duration
      self.skill_template.duration
    end

    def description
      self.skill_template.description
    end
end
