class SkillInstance < OwnedInstance
  self.table_name = :skill_instances
  belongs_to :skill_template
  has_many :modifiers
  has_many :durations
  
  def current_cooldown
    c = self.durations.where("is_cooldown = true").first
    c != nil ? c : Duration.new()
  end
  
  def current_duration
    d = self.durations.where("is_cooldown = false").first
    d != nil ? d : Duration.new()
  end
  
  def update_status(new_duration, new_cooldown)
    cooldown = self.current_cooldown
    duration = self.current_duration
    if new_cooldown != nil
      if cooldown == nil
        Duration.create({current_time: new_cooldown, max_time: self.skill_template.cooldown, skill_instance_id: self.id, is_cooldown:true})
      else
        cooldown.update({current_time: new_cooldown})
      end
    end
    if new_duration != nil
      if duration == nil
        Duration.create({current_time: new_duration, max_time: self.skill_template.duration, skill_instance_id: self.id, is_cooldown: false})
      else
        duration.update({current_time: new_duration})
      end
    end
  end
  
  def current_modifiers
    0
  end
  
  def name
    self.skill_template.name
  end
end
