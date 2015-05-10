class ProficiencyInstance < OwnedInstance
  self.table_name = :proficiency_instances
  belongs_to :proficiency_template
  
  def name
    self.proficiency_template.name
  end
end
