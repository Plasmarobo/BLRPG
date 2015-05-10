class ConsumableInstance < OwnedInstance
  self.table_name = :consumable_instances
  belongs_to :consumable_template
  has_many :modifiers
end
