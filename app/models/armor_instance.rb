class ArmorInstance < OwnedInstance
  self.table_name = :armor_instances
  belongs_to :armor_template
  has_many :modifiers
  
  def cell_data
    {
      current: {
        title: "Deflect",
        value: self.current_deflect != nil ? self.current_deflect : 0
      },
      max: {
        title: "Max",
        value: self.armor_template != nil ? self.armor_template.deflect : 0
      }
    }
  end
end
