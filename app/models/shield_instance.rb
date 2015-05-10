class ShieldInstance < OwnedInstance
  self.table_name = :shield_instances
  belongs_to :shield_template
  has_many :modifiers
  
  def cell_data
    {
      current: {
        title: "Charge",
        value: self.current_capacity != nil ? self.current_capacity : 0
      },
      max: {
        title: "Capacity",
        value: self.shield_template != nil ? self.shield_template.capacity : 0
      }
    }
  end
  
  def name
    self.shield_template.name
  end
end
