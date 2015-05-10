class StackInstance < OwnedInstance
  self.table_name = :stack_instances
  belongs_to :stack_template
  has_many :modifiers
end
