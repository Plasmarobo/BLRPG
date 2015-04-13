class ProficiencyInstance < ActiveRecord::Base
  belongs_to :proficiency_template
  belongs_to :vault_hunter
  
  def name
    self.proficiency_template.name
  end
end
