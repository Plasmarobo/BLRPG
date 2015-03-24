class SkillInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :skill_template
  has_many :modifiers
  has_many :durations
  
  def current_cooldown
    self.durations.where("is_cooldown = true").first
  end
  
  def current_duration
    self.durations.where("is_cooldown = false").first
  end
  
  def current_modifiers
    0
  end
end
