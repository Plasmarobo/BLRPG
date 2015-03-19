class SkillInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :skill_template
  has_many :modifiers
end
